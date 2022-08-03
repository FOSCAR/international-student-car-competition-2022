;; Auto-generated. Do not edit!


(when (boundp 'lidar_team_morai::CtrlSteering)
  (if (not (find-package "LIDAR_TEAM_MORAI"))
    (make-package "LIDAR_TEAM_MORAI"))
  (shadow 'CtrlSteering (find-package "LIDAR_TEAM_MORAI")))
(unless (find-package "LIDAR_TEAM_MORAI::CTRLSTEERING")
  (make-package "LIDAR_TEAM_MORAI::CTRLSTEERING"))

(in-package "ROS")
;;//! \htmlinclude CtrlSteering.msg.html


(defclass lidar_team_morai::CtrlSteering
  :super ros::object
  :slots (_steering ))

(defmethod lidar_team_morai::CtrlSteering
  (:init
   (&key
    ((:steering __steering) 0.0)
    )
   (send-super :init)
   (setq _steering (float __steering))
   self)
  (:steering
   (&optional __steering)
   (if __steering (setq _steering __steering)) _steering)
  (:serialization-length
   ()
   (+
    ;; float64 _steering
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _steering
       (sys::poke _steering (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _steering
     (setq _steering (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get lidar_team_morai::CtrlSteering :md5sum-) "13be5889908f58ce029441890e49203c")
(setf (get lidar_team_morai::CtrlSteering :datatype-) "lidar_team_morai/CtrlSteering")
(setf (get lidar_team_morai::CtrlSteering :definition-)
      "float64 steering
")



(provide :lidar_team_morai/CtrlSteering "13be5889908f58ce029441890e49203c")


