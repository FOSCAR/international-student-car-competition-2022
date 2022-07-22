;; Auto-generated. Do not edit!


(when (boundp 'lidar_team_morai::DynamicObstacle)
  (if (not (find-package "LIDAR_TEAM_MORAI"))
    (make-package "LIDAR_TEAM_MORAI"))
  (shadow 'DynamicObstacle (find-package "LIDAR_TEAM_MORAI")))
(unless (find-package "LIDAR_TEAM_MORAI::DYNAMICOBSTACLE")
  (make-package "LIDAR_TEAM_MORAI::DYNAMICOBSTACLE"))

(in-package "ROS")
;;//! \htmlinclude DynamicObstacle.msg.html


(defclass lidar_team_morai::DynamicObstacle
  :super ros::object
  :slots ())

(defmethod lidar_team_morai::DynamicObstacle
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(setf (get lidar_team_morai::DynamicObstacle :md5sum-) "d41d8cd98f00b204e9800998ecf8427e")
(setf (get lidar_team_morai::DynamicObstacle :datatype-) "lidar_team_morai/DynamicObstacle")
(setf (get lidar_team_morai::DynamicObstacle :definition-)
      "
")



(provide :lidar_team_morai/DynamicObstacle "d41d8cd98f00b204e9800998ecf8427e")


