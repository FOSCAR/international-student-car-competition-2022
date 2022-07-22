
(cl:in-package :asdf)

(defsystem "cam_lidar_calibration-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :actionlib_msgs-msg
               :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "RunOptimiseAction" :depends-on ("_package_RunOptimiseAction"))
    (:file "_package_RunOptimiseAction" :depends-on ("_package"))
    (:file "RunOptimiseActionFeedback" :depends-on ("_package_RunOptimiseActionFeedback"))
    (:file "_package_RunOptimiseActionFeedback" :depends-on ("_package"))
    (:file "RunOptimiseActionGoal" :depends-on ("_package_RunOptimiseActionGoal"))
    (:file "_package_RunOptimiseActionGoal" :depends-on ("_package"))
    (:file "RunOptimiseActionResult" :depends-on ("_package_RunOptimiseActionResult"))
    (:file "_package_RunOptimiseActionResult" :depends-on ("_package"))
    (:file "RunOptimiseFeedback" :depends-on ("_package_RunOptimiseFeedback"))
    (:file "_package_RunOptimiseFeedback" :depends-on ("_package"))
    (:file "RunOptimiseGoal" :depends-on ("_package_RunOptimiseGoal"))
    (:file "_package_RunOptimiseGoal" :depends-on ("_package"))
    (:file "RunOptimiseResult" :depends-on ("_package_RunOptimiseResult"))
    (:file "_package_RunOptimiseResult" :depends-on ("_package"))
  ))