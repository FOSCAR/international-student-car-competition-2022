
(cl:in-package :asdf)

(defsystem "pure_pursuit-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "DynamicObstacle" :depends-on ("_package_DynamicObstacle"))
    (:file "_package_DynamicObstacle" :depends-on ("_package"))
    (:file "StaticObstacle" :depends-on ("_package_StaticObstacle"))
    (:file "_package_StaticObstacle" :depends-on ("_package"))
    (:file "drive_values" :depends-on ("_package_drive_values"))
    (:file "_package_drive_values" :depends-on ("_package"))
  ))