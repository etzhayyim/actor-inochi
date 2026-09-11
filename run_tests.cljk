(require '[clojure.test :as t])

(def suites '[inochi.methods.test-datom-emit
              inochi.methods.test-ie-flow
              inochi.murakumo-test
              inochi.social-publication-test
              inochi.tests.test-analyze
              inochi.tests.test-coverage
              inochi.tests.test-kotoba
              inochi.tests.test-systemic-pressures
              inochi.repository-contract-test])
(apply require suites)
(let [{:keys [fail error]} (apply t/run-tests suites)]
  (System/exit (if (zero? (+ fail error)) 0 1)))
