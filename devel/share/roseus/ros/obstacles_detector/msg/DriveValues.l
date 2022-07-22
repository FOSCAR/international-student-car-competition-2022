;; Auto-generated. Do not edit!


(when (boundp 'obstacles_detector::DriveValues)
  (if (not (find-package "OBSTACLES_DETECTOR"))
    (make-package "OBSTACLES_DETECTOR"))
  (shadow 'DriveValues (find-package "OBSTACLES_DETECTOR")))
(unless (find-package "OBSTACLES_DETECTOR::DRIVEVALUES")
  (make-package "OBSTACLES_DETECTOR::DRIVEVALUES"))

(in-package "ROS")
;;//! \htmlinclude DriveValues.msg.html


(defclass obstacles_detector::DriveValues
  :super ros::object
  :slots (_throttle _steering ))

(defmethod obstacles_detector::DriveValues
  (:init
   (&key
    ((:throttle __throttle) 0)
    ((:steering __steering) 0.0)
    )
   (send-super :init)
   (setq _throttle (round __throttle))
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
    ;; int16 _throttle
    2
    ;; float64 _steering
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int16 _throttle
       (write-word _throttle s)
     ;; float64 _steering
       (sys::poke _steering (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int16 _throttle
     (setq _throttle (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; float64 _steering
     (setq _steering (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get obstacles_detector::DriveValues :md5sum-) "ef2152ed667962c416322fe394052479")
(setf (get obstacles_detector::DriveValues :datatype-) "obstacles_detector/DriveValues")
(setf (get obstacles_detector::DriveValues :definition-)
      "int16 throttle
float64 steering

")



(provide :obstacles_detector/DriveValues "ef2152ed667962c416322fe394052479")


