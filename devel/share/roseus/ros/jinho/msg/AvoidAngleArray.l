;; Auto-generated. Do not edit!


(when (boundp 'jinho::AvoidAngleArray)
  (if (not (find-package "JINHO"))
    (make-package "JINHO"))
  (shadow 'AvoidAngleArray (find-package "JINHO")))
(unless (find-package "JINHO::AVOIDANGLEARRAY")
  (make-package "JINHO::AVOIDANGLEARRAY"))

(in-package "ROS")
;;//! \htmlinclude AvoidAngleArray.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass jinho::AvoidAngleArray
  :super ros::object
  :slots (_header _total _minAngle _maxAngle ))

(defmethod jinho::AvoidAngleArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:total __total) 0)
    ((:minAngle __minAngle) (make-array 20 :initial-element 0.0 :element-type :float))
    ((:maxAngle __maxAngle) (make-array 20 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _total (round __total))
   (setq _minAngle __minAngle)
   (setq _maxAngle __maxAngle)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:total
   (&optional __total)
   (if __total (setq _total __total)) _total)
  (:minAngle
   (&optional __minAngle)
   (if __minAngle (setq _minAngle __minAngle)) _minAngle)
  (:maxAngle
   (&optional __maxAngle)
   (if __maxAngle (setq _maxAngle __maxAngle)) _maxAngle)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int8 _total
    1
    ;; float64[20] _minAngle
    (* 8    20)
    ;; float64[20] _maxAngle
    (* 8    20)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int8 _total
       (write-byte _total s)
     ;; float64[20] _minAngle
     (dotimes (i 20)
       (sys::poke (elt _minAngle i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[20] _maxAngle
     (dotimes (i 20)
       (sys::poke (elt _maxAngle i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int8 _total
     (setq _total (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _total 127) (setq _total (- _total 256)))
   ;; float64[20] _minAngle
   (dotimes (i (length _minAngle))
     (setf (elt _minAngle i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[20] _maxAngle
   (dotimes (i (length _maxAngle))
     (setf (elt _maxAngle i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;;
   self)
  )

(setf (get jinho::AvoidAngleArray :md5sum-) "175df850181b1f133e7b830da57e6220")
(setf (get jinho::AvoidAngleArray :datatype-) "jinho/AvoidAngleArray")
(setf (get jinho::AvoidAngleArray :definition-)
      "Header header
int8 total
float64[20] minAngle
float64[20] maxAngle
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :jinho/AvoidAngleArray "175df850181b1f133e7b830da57e6220")


