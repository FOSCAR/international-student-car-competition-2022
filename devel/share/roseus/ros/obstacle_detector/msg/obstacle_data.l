;; Auto-generated. Do not edit!


(when (boundp 'obstacle_detector::obstacle_data)
  (if (not (find-package "OBSTACLE_DETECTOR"))
    (make-package "OBSTACLE_DETECTOR"))
  (shadow 'obstacle_data (find-package "OBSTACLE_DETECTOR")))
(unless (find-package "OBSTACLE_DETECTOR::OBSTACLE_DATA")
  (make-package "OBSTACLE_DETECTOR::OBSTACLE_DATA"))

(in-package "ROS")
;;//! \htmlinclude obstacle_data.msg.html


(defclass obstacle_detector::obstacle_data
  :super ros::object
  :slots (_coordinate_x _coordinate_y _coordinate_z _volume _distance ))

(defmethod obstacle_detector::obstacle_data
  (:init
   (&key
    ((:coordinate_x __coordinate_x) 0.0)
    ((:coordinate_y __coordinate_y) 0.0)
    ((:coordinate_z __coordinate_z) 0.0)
    ((:volume __volume) 0.0)
    ((:distance __distance) 0.0)
    )
   (send-super :init)
   (setq _coordinate_x (float __coordinate_x))
   (setq _coordinate_y (float __coordinate_y))
   (setq _coordinate_z (float __coordinate_z))
   (setq _volume (float __volume))
   (setq _distance (float __distance))
   self)
  (:coordinate_x
   (&optional __coordinate_x)
   (if __coordinate_x (setq _coordinate_x __coordinate_x)) _coordinate_x)
  (:coordinate_y
   (&optional __coordinate_y)
   (if __coordinate_y (setq _coordinate_y __coordinate_y)) _coordinate_y)
  (:coordinate_z
   (&optional __coordinate_z)
   (if __coordinate_z (setq _coordinate_z __coordinate_z)) _coordinate_z)
  (:volume
   (&optional __volume)
   (if __volume (setq _volume __volume)) _volume)
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:serialization-length
   ()
   (+
    ;; float64 _coordinate_x
    8
    ;; float64 _coordinate_y
    8
    ;; float64 _coordinate_z
    8
    ;; float64 _volume
    8
    ;; float64 _distance
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _coordinate_x
       (sys::poke _coordinate_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _coordinate_y
       (sys::poke _coordinate_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _coordinate_z
       (sys::poke _coordinate_z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _volume
       (sys::poke _volume (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _distance
       (sys::poke _distance (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _coordinate_x
     (setq _coordinate_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _coordinate_y
     (setq _coordinate_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _coordinate_z
     (setq _coordinate_z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _volume
     (setq _volume (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _distance
     (setq _distance (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get obstacle_detector::obstacle_data :md5sum-) "55c5c0fa4c104cd9d5bf8f06e255b85f")
(setf (get obstacle_detector::obstacle_data :datatype-) "obstacle_detector/obstacle_data")
(setf (get obstacle_detector::obstacle_data :definition-)
      "float64 coordinate_x
float64 coordinate_y
float64 coordinate_z
float64 volume
float64 distance

")



(provide :obstacle_detector/obstacle_data "55c5c0fa4c104cd9d5bf8f06e255b85f")


