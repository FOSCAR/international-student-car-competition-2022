;; Auto-generated. Do not edit!


(when (boundp 'lidar_team_morai::CtrlVelocity)
  (if (not (find-package "LIDAR_TEAM_MORAI"))
    (make-package "LIDAR_TEAM_MORAI"))
  (shadow 'CtrlVelocity (find-package "LIDAR_TEAM_MORAI")))
(unless (find-package "LIDAR_TEAM_MORAI::CTRLVELOCITY")
  (make-package "LIDAR_TEAM_MORAI::CTRLVELOCITY"))

(in-package "ROS")
;;//! \htmlinclude CtrlVelocity.msg.html


(defclass lidar_team_morai::CtrlVelocity
  :super ros::object
  :slots (_velocity ))

(defmethod lidar_team_morai::CtrlVelocity
  (:init
   (&key
    ((:velocity __velocity) 0.0)
    )
   (send-super :init)
   (setq _velocity (float __velocity))
   self)
  (:velocity
   (&optional __velocity)
   (if __velocity (setq _velocity __velocity)) _velocity)
  (:serialization-length
   ()
   (+
    ;; float64 _velocity
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _velocity
       (sys::poke _velocity (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _velocity
     (setq _velocity (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get lidar_team_morai::CtrlVelocity :md5sum-) "6d3b2ef8452c2fe21adb709618d2518f")
(setf (get lidar_team_morai::CtrlVelocity :datatype-) "lidar_team_morai/CtrlVelocity")
(setf (get lidar_team_morai::CtrlVelocity :definition-)
      "float64 velocity
")



(provide :lidar_team_morai/CtrlVelocity "6d3b2ef8452c2fe21adb709618d2518f")


