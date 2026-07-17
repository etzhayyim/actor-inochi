#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
exec bb -e '
(require (quote clojure.test)
         (quote inochi.methods.test-datom-emit)
         (quote inochi.methods.test-ie-flow)
         (quote inochi.murakumo-test)
         (quote inochi.social-publication-test)
         (quote inochi.tests.test-analyze)
         (quote inochi.tests.test-coverage)
         (quote inochi.tests.test-kotoba)
         (quote inochi.tests.test-systemic-pressures))
(let [namespaces [                  (quote inochi.methods.test-datom-emit)
                  (quote inochi.methods.test-ie-flow)
                  (quote inochi.murakumo-test)
                  (quote inochi.social-publication-test)
                  (quote inochi.tests.test-analyze)
                  (quote inochi.tests.test-coverage)
                  (quote inochi.tests.test-kotoba)
                  (quote inochi.tests.test-systemic-pressures)]
      result (apply clojure.test/run-tests namespaces)]
  (System/exit (if (zero? (+ (:fail result) (:error result))) 0 1)))'
