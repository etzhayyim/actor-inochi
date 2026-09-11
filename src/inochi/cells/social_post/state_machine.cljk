(ns inochi.cells.social-post.state-machine
  "Actor state-machine adapter over the shared publication membrane."
  (:require [etzhayyim.social.publication :as publication]
            [inochi.methods.social :as social]))

(def disclaimer publication/disclaimer-prefix)
(def phase-init publication/phase-init)
(def phase-drafted publication/phase-drafted)
(def phase-refused publication/phase-refused)
(def state-defaults publication/state-defaults)

(defn transition-to-drafted [state]
  (publication/transition-to-drafted social/config state))
