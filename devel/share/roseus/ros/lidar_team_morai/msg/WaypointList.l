;; Auto-generated. Do not edit!


(when (boundp 'lidar_team_morai::WaypointList)
  (if (not (find-package "LIDAR_TEAM_MORAI"))
    (make-package "LIDAR_TEAM_MORAI"))
  (shadow 'WaypointList (find-package "LIDAR_TEAM_MORAI")))
(unless (find-package "LIDAR_TEAM_MORAI::WAYPOINTLIST")
  (make-package "LIDAR_TEAM_MORAI::WAYPOINTLIST"))

(in-package "ROS")
;;//! \htmlinclude WaypointList.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass lidar_team_morai::WaypointList
  :super ros::object
  :slots (_header _info ))

(defmethod lidar_team_morai::WaypointList
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:info __info) (let (r) (dotimes (i 0) (push (instance lidar_team_morai::Waypoint :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _info __info)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:info
   (&rest __info)
   (if (keywordp (car __info))
       (send* _info __info)
     (progn
       (if __info (setq _info (car __info)))
       _info)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; lidar_team_morai/Waypoint[] _info
    (apply #'+ (send-all _info :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; lidar_team_morai/Waypoint[] _info
     (write-long (length _info) s)
     (dolist (elem _info)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; lidar_team_morai/Waypoint[] _info
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _info (let (r) (dotimes (i n) (push (instance lidar_team_morai::Waypoint :init) r)) r))
     (dolist (elem- _info)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get lidar_team_morai::WaypointList :md5sum-) "5103fdd73a1575a4d565f16f08c82984")
(setf (get lidar_team_morai::WaypointList :datatype-) "lidar_team_morai/WaypointList")
(setf (get lidar_team_morai::WaypointList :definition-)
      "Header header

Waypoint[] info
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
MSG: lidar_team_morai/Waypoint
int32 cnt
float32[200] x_arr
float32[200] y_arr
")



(provide :lidar_team_morai/WaypointList "5103fdd73a1575a4d565f16f08c82984")


