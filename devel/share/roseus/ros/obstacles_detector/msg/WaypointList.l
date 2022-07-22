;; Auto-generated. Do not edit!


(when (boundp 'obstacles_detector::WaypointList)
  (if (not (find-package "OBSTACLES_DETECTOR"))
    (make-package "OBSTACLES_DETECTOR"))
  (shadow 'WaypointList (find-package "OBSTACLES_DETECTOR")))
(unless (find-package "OBSTACLES_DETECTOR::WAYPOINTLIST")
  (make-package "OBSTACLES_DETECTOR::WAYPOINTLIST"))

(in-package "ROS")
;;//! \htmlinclude WaypointList.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass obstacles_detector::WaypointList
  :super ros::object
  :slots (_header _list ))

(defmethod obstacles_detector::WaypointList
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:list __list) (let (r) (dotimes (i 0) (push (instance obstacles_detector::Waypoint :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _list __list)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:list
   (&rest __list)
   (if (keywordp (car __list))
       (send* _list __list)
     (progn
       (if __list (setq _list (car __list)))
       _list)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; obstacles_detector/Waypoint[] _list
    (apply #'+ (send-all _list :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; obstacles_detector/Waypoint[] _list
     (write-long (length _list) s)
     (dolist (elem _list)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; obstacles_detector/Waypoint[] _list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _list (let (r) (dotimes (i n) (push (instance obstacles_detector::Waypoint :init) r)) r))
     (dolist (elem- _list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get obstacles_detector::WaypointList :md5sum-) "a4ae0fee55df3baa0344e6959a295b8c")
(setf (get obstacles_detector::WaypointList :datatype-) "obstacles_detector/WaypointList")
(setf (get obstacles_detector::WaypointList :definition-)
      "Header header

Waypoint[] list 
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

================================================================================
MSG: obstacles_detector/Waypoint
Header header

float64 x
float64 y
")



(provide :obstacles_detector/WaypointList "a4ae0fee55df3baa0344e6959a295b8c")


