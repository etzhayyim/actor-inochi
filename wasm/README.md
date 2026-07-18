# inochi 命 — kotoba WASM actor boundary

Historical design for running inochi's analyzer as a content-addressed actor under the
"one Worker, many WASM actors" model (ADR-2606014500 / 2606014600). The only
first-party Cloudflare Worker is `etzhayyim.com` (identity / `did.json`); the actor
itself is a **content-addressed WASM component** fetched from IPFS and run **locally**
(browser via ameno, or a donated mesh node via e7m-wasm-runner) — there is **no
per-actor server** (no-server-key).

## Current substrate

The former Python implementation has been retired. Canonical implementations are portable
CLJC under `src/inochi/methods/`; the mesh/runtime owns component compilation. The
edge-primary 取-concentration remains a graph integral over `:en/grasping-load` with no
native numerical dependency. The same source runs:

- as a substrate-native CLJC cell on a mesh node, and
- in-WASM in the browser (ameno) with **zero server trust** — the reader recomputes the
  component CID and compares it to the DID-doc CID before executing.

## Component ABI (WIT sketch)

```wit
package etzhayyim:inochi@0.1.0;

world inochi-actor {
  /// run the analyzer over an embedded :representative biosphere graph (G1: no coords).
  /// returns JSON: { restoration:[{id,label,iucn,score}], pressures:[...], fragility:[...] }
  export analyze: func() -> string;

  /// emit the kotoba Datom log (EAVT) for the embedded graph as EDN text.
  export datoms: func(tx: u32) -> string;

  /// honest coverage report (markdown).
  export coverage: func() -> string;
}
```

`analyze.cljc` / `datom_emit.cljc` / `coverage_report.cljc` provide the three bodies; the
embedded seed is bundled read-only into the component (no filesystem at runtime).

## Build & verify (target)

```bash
# componentize-py — bundle the pure-stdlib methods + embedded seed into a Component
componentize-py -w inochi-actor componentize actor -o dist/inochi.wasm
# content-address the artifact (CIDv1, raw/sha2-256) and carry it in the actor DID doc
ipfs add --cid-version=1 --raw-leaves dist/inochi.wasm > dist/inochi.cid
node ../../tsumugi/wasm/loader/verify.mjs dist/inochi.wasm   # reuse headless CID-verify path
```

The resulting CID is advertised in the actor's `did.json` as an `EtzhayyimWasmComponent`
service (`ipfs://<cid>`), issued dynamically by the apex Worker (ADR-2606013800) from
`:actor/wasm-cid` in the kotoba `actors-v1` graph.

## Trust model

- **No server key.** The component is read-only; it never signs. Identity is the actor's
  own `did:key` + the content-addressed DID doc (ADR-2606015600).
- **Integrity before execution.** ameno / e7m recompute the CID and refuse on mismatch.
- **G1 holds in WASM too.** The embedded seed carries no occurrence coordinates; the
  component cannot leak what it does not contain.

## Status

R0 design-only. Methods are pywasm-ready (pure stdlib, verified green); the
componentize-py build + CID advertisement land with the actor's first WASM deploy wave
(gated like tsumugi's, ADR-2606014500).
