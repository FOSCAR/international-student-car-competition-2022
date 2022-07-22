;; Auto-generated. Do not edit!


(when (boundp 'lidar_team_morai::StaticObstacle)
  (if (not (find-package "LIDAR_TEAM_MORAI"))
    (make-package "LIDAR_TEAM_MORAI"))
  (shadow 'StaticObstacle (find-package "LIDAR_TEAM_MORAI")))
(unless (find-package "LIDAR_TEAM_MORAI::STATICOBSTACLE")
  (make-package "LIDAR_TEAM_MORAI::STATICOBSTACLE"))

(in-package "ROS")
;;//! \htmlinclude StaticObstacle.msg.html


(defclass lidar_team_morai::StaticObstacle
  :super ros::object
  :slots ())

(defmethod lidar_team_morai::StaticObstacle
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

(setf (get lidar_team_morai::StaticObstacle :md5sum-) "d41d8cd98f00b204e9800998ecf8427e")
(setf (get lidar_team_morai::StaticObstacle :datatype-) "lidar_team_morai/StaticObstacle")
(setf (get lidar_team_morai::StaticObstacle :definition-)
      "
")



(provide :lidar_team_morai/StaticObstacle "d41d8cd98f00b204e9800998ecf8427e")


