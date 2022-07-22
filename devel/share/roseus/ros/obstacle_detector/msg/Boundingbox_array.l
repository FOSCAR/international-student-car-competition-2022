;; Auto-generated. Do not edit!


(when (boundp 'obstacle_detector::Boundingbox_array)
  (if (not (find-package "OBSTACLE_DETECTOR"))
    (make-package "OBSTACLE_DETECTOR"))
  (shadow 'Boundingbox_array (find-package "OBSTACLE_DETECTOR")))
(unless (find-package "OBSTACLE_DETECTOR::BOUNDINGBOX_ARRAY")
  (make-package "OBSTACLE_DETECTOR::BOUNDINGBOX_ARRAY"))

(in-package "ROS")
;;//! \htmlinclude Boundingbox_array.msg.html


(defclass obstacle_detector::Boundingbox_array
  :super ros::object
  :slots (_boundingbox_array ))

(defmethod obstacle_detector::Boundingbox_array
  (:init
   (&key
    ((:boundingbox_array __boundingbox_array) (let (r) (dotimes (i 0) (push (instance obstacle_detector::Boundingbox :init) r)) r))
    )
   (send-super :init)
   (setq _boundingbox_array __boundingbox_array)
   self)
  (:boundingbox_array
   (&rest __boundingbox_array)
   (if (keywordp (car __boundingbox_array))
       (send* _boundingbox_array __boundingbox_array)
     (progn
       (if __boundingbox_array (setq _boundingbox_array (car __boundingbox_array)))
       _boundingbox_array)))
  (:serialization-length
   ()
   (+
    ;; obstacle_detector/Boundingbox[] _boundingbox_array
    (apply #'+ (send-all _boundingbox_array :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; obstacle_detector/Boundingbox[] _boundingbox_array
     (write-long (length _boundingbox_array) s)
     (dolist (elem _boundingbox_array)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; obstacle_detector/Boundingbox[] _boundingbox_array
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _boundingbox_array (let (r) (dotimes (i n) (push (instance obstacle_detector::Boundingbox :init) r)) r))
     (dolist (elem- _boundingbox_array)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get obstacle_detector::Boundingbox_array :md5sum-) "72f4806878af1954f3e5c66182495641")
(setf (get obstacle_detector::Boundingbox_array :datatype-) "obstacle_detector/Boundingbox_array")
(setf (get obstacle_detector::Boundingbox_array :definition-)
      "Boundingbox[] boundingbox_array

================================================================================
MSG: obstacle_detector/Boundingbox
float64 x
float64 y
float64 z
float64 volume
float64 distance

")



(provide :obstacle_detector/Boundingbox_array "72f4806878af1954f3e5c66182495641")


