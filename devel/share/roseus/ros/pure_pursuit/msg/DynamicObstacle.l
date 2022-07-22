;; Auto-generated. Do not edit!


(when (boundp 'pure_pursuit::DynamicObstacle)
  (if (not (find-package "PURE_PURSUIT"))
    (make-package "PURE_PURSUIT"))
  (shadow 'DynamicObstacle (find-package "PURE_PURSUIT")))
(unless (find-package "PURE_PURSUIT::DYNAMICOBSTACLE")
  (make-package "PURE_PURSUIT::DYNAMICOBSTACLE"))

(in-package "ROS")
;;//! \htmlinclude DynamicObstacle.msg.html


(defclass pure_pursuit::DynamicObstacle
  :super ros::object
  :slots (_is_dynamic_obs_detected_short _is_dynamic_obs_detected_long ))

(defmethod pure_pursuit::DynamicObstacle
  (:init
   (&key
    ((:is_dynamic_obs_detected_short __is_dynamic_obs_detected_short) nil)
    ((:is_dynamic_obs_detected_long __is_dynamic_obs_detected_long) nil)
    )
   (send-super :init)
   (setq _is_dynamic_obs_detected_short __is_dynamic_obs_detected_short)
   (setq _is_dynamic_obs_detected_long __is_dynamic_obs_detected_long)
   self)
  (:is_dynamic_obs_detected_short
   (&optional __is_dynamic_obs_detected_short)
   (if __is_dynamic_obs_detected_short (setq _is_dynamic_obs_detected_short __is_dynamic_obs_detected_short)) _is_dynamic_obs_detected_short)
  (:is_dynamic_obs_detected_long
   (&optional __is_dynamic_obs_detected_long)
   (if __is_dynamic_obs_detected_long (setq _is_dynamic_obs_detected_long __is_dynamic_obs_detected_long)) _is_dynamic_obs_detected_long)
  (:serialization-length
   ()
   (+
    ;; bool _is_dynamic_obs_detected_short
    1
    ;; bool _is_dynamic_obs_detected_long
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _is_dynamic_obs_detected_short
       (if _is_dynamic_obs_detected_short (write-byte -1 s) (write-byte 0 s))
     ;; bool _is_dynamic_obs_detected_long
       (if _is_dynamic_obs_detected_long (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _is_dynamic_obs_detected_short
     (setq _is_dynamic_obs_detected_short (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _is_dynamic_obs_detected_long
     (setq _is_dynamic_obs_detected_long (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get pure_pursuit::DynamicObstacle :md5sum-) "c882ecd689b24462667336642ad7283e")
(setf (get pure_pursuit::DynamicObstacle :datatype-) "pure_pursuit/DynamicObstacle")
(setf (get pure_pursuit::DynamicObstacle :definition-)
      "bool is_dynamic_obs_detected_short
bool is_dynamic_obs_detected_long
")



(provide :pure_pursuit/DynamicObstacle "c882ecd689b24462667336642ad7283e")


