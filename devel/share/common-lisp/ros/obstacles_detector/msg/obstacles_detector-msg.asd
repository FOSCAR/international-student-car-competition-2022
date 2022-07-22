
(cl:in-package :asdf)

(defsystem "obstacles_detector-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Boundingbox" :depends-on ("_package_Boundingbox"))
    (:file "_package_Boundingbox" :depends-on ("_package"))
    (:file "DriveValues" :depends-on ("_package_DriveValues"))
    (:file "_package_DriveValues" :depends-on ("_package"))
    (:file "Waypoint" :depends-on ("_package_Waypoint"))
    (:file "_package_Waypoint" :depends-on ("_package"))
    (:file "WaypointList" :depends-on ("_package_WaypointList"))
    (:file "_package_WaypointList" :depends-on ("_package"))
  ))