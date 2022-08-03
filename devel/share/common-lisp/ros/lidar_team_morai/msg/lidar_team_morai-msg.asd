
(cl:in-package :asdf)

(defsystem "lidar_team_morai-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Boundingbox" :depends-on ("_package_Boundingbox"))
    (:file "_package_Boundingbox" :depends-on ("_package"))
    (:file "CtrlSteering" :depends-on ("_package_CtrlSteering"))
    (:file "_package_CtrlSteering" :depends-on ("_package"))
    (:file "CtrlVelocity" :depends-on ("_package_CtrlVelocity"))
    (:file "_package_CtrlVelocity" :depends-on ("_package"))
    (:file "ObjectInfo" :depends-on ("_package_ObjectInfo"))
    (:file "_package_ObjectInfo" :depends-on ("_package"))
    (:file "PurePursuit" :depends-on ("_package_PurePursuit"))
    (:file "_package_PurePursuit" :depends-on ("_package"))
    (:file "VescState" :depends-on ("_package_VescState"))
    (:file "_package_VescState" :depends-on ("_package"))
    (:file "VescStateStamped" :depends-on ("_package_VescStateStamped"))
    (:file "_package_VescStateStamped" :depends-on ("_package"))
    (:file "Waypoint" :depends-on ("_package_Waypoint"))
    (:file "_package_Waypoint" :depends-on ("_package"))
  ))