
(cl:in-package :asdf)

(defsystem "cam_lidar_calibration-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Optimise" :depends-on ("_package_Optimise"))
    (:file "_package_Optimise" :depends-on ("_package"))
  ))