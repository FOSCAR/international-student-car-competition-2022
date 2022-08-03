; Auto-generated. Do not edit!


(cl:in-package lidar_team_morai-msg)


;//! \htmlinclude CtrlSteering.msg.html

(cl:defclass <CtrlSteering> (roslisp-msg-protocol:ros-message)
  ((steering
    :reader steering
    :initarg :steering
    :type cl:float
    :initform 0.0))
)

(cl:defclass CtrlSteering (<CtrlSteering>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CtrlSteering>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CtrlSteering)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lidar_team_morai-msg:<CtrlSteering> is deprecated: use lidar_team_morai-msg:CtrlSteering instead.")))

(cl:ensure-generic-function 'steering-val :lambda-list '(m))
(cl:defmethod steering-val ((m <CtrlSteering>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lidar_team_morai-msg:steering-val is deprecated.  Use lidar_team_morai-msg:steering instead.")
  (steering m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CtrlSteering>) ostream)
  "Serializes a message object of type '<CtrlSteering>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'steering))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CtrlSteering>) istream)
  "Deserializes a message object of type '<CtrlSteering>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steering) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CtrlSteering>)))
  "Returns string type for a message object of type '<CtrlSteering>"
  "lidar_team_morai/CtrlSteering")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CtrlSteering)))
  "Returns string type for a message object of type 'CtrlSteering"
  "lidar_team_morai/CtrlSteering")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CtrlSteering>)))
  "Returns md5sum for a message object of type '<CtrlSteering>"
  "13be5889908f58ce029441890e49203c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CtrlSteering)))
  "Returns md5sum for a message object of type 'CtrlSteering"
  "13be5889908f58ce029441890e49203c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CtrlSteering>)))
  "Returns full string definition for message of type '<CtrlSteering>"
  (cl:format cl:nil "float64 steering~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CtrlSteering)))
  "Returns full string definition for message of type 'CtrlSteering"
  (cl:format cl:nil "float64 steering~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CtrlSteering>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CtrlSteering>))
  "Converts a ROS message object to a list"
  (cl:list 'CtrlSteering
    (cl:cons ':steering (steering msg))
))
