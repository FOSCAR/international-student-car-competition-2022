
(cl:in-package :asdf)

(defsystem "jinho-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "AvoidAngleArray" :depends-on ("_package_AvoidAngleArray"))
    (:file "_package_AvoidAngleArray" :depends-on ("_package"))
    (:file "DriveValue" :depends-on ("_package_DriveValue"))
    (:file "_package_DriveValue" :depends-on ("_package"))
    (:file "PurePursuit" :depends-on ("_package_PurePursuit"))
    (:file "_package_PurePursuit" :depends-on ("_package"))
  ))