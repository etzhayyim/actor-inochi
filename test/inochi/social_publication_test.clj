(ns inochi.social-publication-test
  (:require [clojure.test :refer [deftest is]]
            [inochi.cells.social-post.state-machine :as cell]
            [inochi.methods.social :as social]))

(deftest actor-adapter-preserves-shared-gates
  (let [post (social/draft-observation-post "subject" "body" ["a" "b"])
        drafted (cell/transition-to-drafted {"subject" "subject" "sources" ["a" "b"]})
        refused (cell/transition-to-drafted
                 {"subject" "subject" "sources" ["a" "b"] "server_held_key" true})]
    (is (= ":dry-run" (get post ":post/status")))
    (is (false? (get post ":post/server-held-key")))
    (is (= cell/phase-drafted (get-in drafted ["cell_state" "phase"])))
    (is (= cell/phase-refused (get-in refused ["cell_state" "phase"])))
    (is (thrown? clojure.lang.ExceptionInfo (social/build-live {})))))
