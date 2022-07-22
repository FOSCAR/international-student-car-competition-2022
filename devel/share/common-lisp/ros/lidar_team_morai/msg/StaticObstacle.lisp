; Auto-generated. Do not edit!


(cl:in-package lidar_team_morai-msg)


;//! \htmlinclude StaticObstacle.msg.html

(cl:defclass <StaticObstacle> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass StaticObstacle (<StaticObstacle>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StaticObstacle>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StaticObstacle)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lidar_team_morai-msg:<StaticObstacle> is deprecated: use lidar_team_morai-msg:StaticObstacle instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StaticObstacle>) ostream)
  "Serializes a message object of type '<StaticObstacle>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StaticObstacle>) istream)
  "Deserializes a message object of type '<StaticObstacle>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StaticObstacle>)))
  "Returns string type for a message object of type '<StaticObstacle>"
  "lidar_team_morai/StaticObstacle")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StaticObstacle)))
  "Returns string type for a message object of type 'StaticObstacle"
  "lidar_team_morai/StaticObstacle")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StaticObstacle>)))
  "Returns md5sum for a message object of type '<StaticObstacle>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StaticObstacle)))
  "Returns md5sum for a message object of type 'StaticObstacle"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StaticObstacle>)))
  "Returns full string definition for message of type '<StaticObstacle>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StaticObstacle)))
  "Returns full string definition for message of type 'StaticObstacle"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StaticObstacle>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StaticObstacle>))
  "Converts a ROS message object to a list"
  (cl:list 'StaticObstacle
))
