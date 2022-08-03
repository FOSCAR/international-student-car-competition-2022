;; Auto-generated. Do not edit!


(when (boundp 'lidar_team_erp42::PurePursuit)
  (if (not (find-package "LIDAR_TEAM_ERP42"))
    (make-package "LIDAR_TEAM_ERP42"))
  (shadow 'PurePursuit (find-package "LIDAR_TEAM_ERP42")))
(unless (find-package "LIDAR_TEAM_ERP42::PUREPURSUIT")
  (make-package "LIDAR_TEAM_ERP42::PUREPURSUIT"))

(in-package "ROS")
;;//! \htmlinclude PurePursuit.msg.html


(defclass lidar_team_erp42::PurePursuit
  :super ros::object
  :slots (_throttle _steering ))

(defmethod lidar_team_erp42::PurePursuit
  (:init
   (&key
    ((:throttle __throttle) 0.0)
    ((:steering __steering) 0.0)
    )
   (send-super :init)
   (setq _throttle (float __throttle))
   (setq _steering (float __steering))
   self)
  (:throttle
   (&optional __throttle)
   (if __throttle (setq _throttle __throttle)) _throttle)
  (:steering
   (&optional __steering)
   (if __steering (setq _steering __steering)) _steering)
  (:serialization-length
   ()
   (+
    ;; float64 _throttle
    8
    ;; float64 _steering
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _throttle
       (sys::poke _throttle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _steering
       (sys::poke _steering (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _throttle
     (setq _throttle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _steering
     (setq _steering (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get lidar_team_erp42::PurePursuit :md5sum-) "39f463d271c2ca10c14182802c72c029")
(setf (get lidar_team_erp42::PurePursuit :datatype-) "lidar_team_erp42/PurePursuit")
(setf (get lidar_team_erp42::PurePursuit :definition-)
      "float64 throttle
float64 steering
")



(provide :lidar_team_erp42/PurePursuit "39f463d271c2ca10c14182802c72c029")


