;; Auto-generated. Do not edit!


(when (boundp 'pure_pursuit::StaticObstacle)
  (if (not (find-package "PURE_PURSUIT"))
    (make-package "PURE_PURSUIT"))
  (shadow 'StaticObstacle (find-package "PURE_PURSUIT")))
(unless (find-package "PURE_PURSUIT::STATICOBSTACLE")
  (make-package "PURE_PURSUIT::STATICOBSTACLE"))

(in-package "ROS")
;;//! \htmlinclude StaticObstacle.msg.html


(defclass pure_pursuit::StaticObstacle
  :super ros::object
  :slots (_is_static_obs_detected_short _is_static_obs_detected_long ))

(defmethod pure_pursuit::StaticObstacle
  (:init
   (&key
    ((:is_static_obs_detected_short __is_static_obs_detected_short) nil)
    ((:is_static_obs_detected_long __is_static_obs_detected_long) nil)
    )
   (send-super :init)
   (setq _is_static_obs_detected_short __is_static_obs_detected_short)
   (setq _is_static_obs_detected_long __is_static_obs_detected_long)
   self)
  (:is_static_obs_detected_short
   (&optional __is_static_obs_detected_short)
   (if __is_static_obs_detected_short (setq _is_static_obs_detected_short __is_static_obs_detected_short)) _is_static_obs_detected_short)
  (:is_static_obs_detected_long
   (&optional __is_static_obs_detected_long)
   (if __is_static_obs_detected_long (setq _is_static_obs_detected_long __is_static_obs_detected_long)) _is_static_obs_detected_long)
  (:serialization-length
   ()
   (+
    ;; bool _is_static_obs_detected_short
    1
    ;; bool _is_static_obs_detected_long
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _is_static_obs_detected_short
       (if _is_static_obs_detected_short (write-byte -1 s) (write-byte 0 s))
     ;; bool _is_static_obs_detected_long
       (if _is_static_obs_detected_long (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _is_static_obs_detected_short
     (setq _is_static_obs_detected_short (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _is_static_obs_detected_long
     (setq _is_static_obs_detected_long (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get pure_pursuit::StaticObstacle :md5sum-) "9029ace2c97c95b725648b05842baa15")
(setf (get pure_pursuit::StaticObstacle :datatype-) "pure_pursuit/StaticObstacle")
(setf (get pure_pursuit::StaticObstacle :definition-)
      "bool is_static_obs_detected_short
bool is_static_obs_detected_long
")



(provide :pure_pursuit/StaticObstacle "9029ace2c97c95b725648b05842baa15")


