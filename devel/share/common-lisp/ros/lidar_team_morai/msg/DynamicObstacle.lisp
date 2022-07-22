; Auto-generated. Do not edit!


(cl:in-package lidar_team_morai-msg)


;//! \htmlinclude DynamicObstacle.msg.html

(cl:defclass <DynamicObstacle> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass DynamicObstacle (<DynamicObstacle>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DynamicObstacle>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DynamicObstacle)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lidar_team_morai-msg:<DynamicObstacle> is deprecated: use lidar_team_morai-msg:DynamicObstacle instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DynamicObstacle>) ostream)
  "Serializes a message object of type '<DynamicObstacle>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DynamicObstacle>) istream)
  "Deserializes a message object of type '<DynamicObstacle>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DynamicObstacle>)))
  "Returns string type for a message object of type '<DynamicObstacle>"
  "lidar_team_morai/DynamicObstacle")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DynamicObstacle)))
  "Returns string type for a message object of type 'DynamicObstacle"
  "lidar_team_morai/DynamicObstacle")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DynamicObstacle>)))
  "Returns md5sum for a message object of type '<DynamicObstacle>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DynamicObstacle)))
  "Returns md5sum for a message object of type 'DynamicObstacle"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DynamicObstacle>)))
  "Returns full string definition for message of type '<DynamicObstacle>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DynamicObstacle)))
  "Returns full string definition for message of type 'DynamicObstacle"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DynamicObstacle>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DynamicObstacle>))
  "Converts a ROS message object to a list"
  (cl:list 'DynamicObstacle
))
