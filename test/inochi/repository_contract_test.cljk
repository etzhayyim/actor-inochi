(ns inochi.repository-contract-test
  (:require [clojure.edn :as edn]
            [clojure.java.io :as io]
            [clojure.test :refer [deftest is]]))

(deftest canonical-repository-shape
  (doseq [path ["manifest.edn" "identity.edn" "dependencies.edn"
                "repository-contracts.edn" "kotoba.app.edn"
                "data/seed-biosphere-graph.kotoba.edn"]]
    (is (some? (edn/read-string (slurp path))) path))
  (doseq [path ["actor.edn" "manifest.jsonld" "run_tests.sh" "methods/publish.bb"]]
    (is (not (.exists (io/file path))) path))
  (is (.isFile (io/file "wire/manifest.jsonld"))))
