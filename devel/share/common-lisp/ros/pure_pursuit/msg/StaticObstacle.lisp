; Auto-generated. Do not edit!


(cl:in-package pure_pursuit-msg)


;//! \htmlinclude StaticObstacle.msg.html

(cl:defclass <StaticObstacle> (roslisp-msg-protocol:ros-message)
  ((is_static_obs_detected_short
    :reader is_static_obs_detected_short
    :initarg :is_static_obs_detected_short
    :type cl:boolean
    :initform cl:nil)
   (is_static_obs_detected_long
    :reader is_static_obs_detected_long
    :initarg :is_static_obs_detected_long
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass StaticObstacle (<StaticObstacle>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StaticObstacle>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StaticObstacle)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name pure_pursuit-msg:<StaticObstacle> is deprecated: use pure_pursuit-msg:StaticObstacle instead.")))

(cl:ensure-generic-function 'is_static_obs_detected_short-val :lambda-list '(m))
(cl:defmethod is_static_obs_detected_short-val ((m <StaticObstacle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pure_pursuit-msg:is_static_obs_detected_short-val is deprecated.  Use pure_pursuit-msg:is_static_obs_detected_short instead.")
  (is_static_obs_detected_short m))

(cl:ensure-generic-function 'is_static_obs_detected_long-val :lambda-list '(m))
(cl:defmethod is_static_obs_detected_long-val ((m <StaticObstacle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pure_pursuit-msg:is_static_obs_detected_long-val is deprecated.  Use pure_pursuit-msg:is_static_obs_detected_long instead.")
  (is_static_obs_detected_long m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StaticObstacle>) ostream)
  "Serializes a message object of type '<StaticObstacle>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_static_obs_detected_short) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_static_obs_detected_long) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StaticObstacle>) istream)
  "Deserializes a message object of type '<StaticObstacle>"
    (cl:setf (cl:slot-value msg 'is_static_obs_detected_short) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'is_static_obs_detected_long) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StaticObstacle>)))
  "Returns string type for a message object of type '<StaticObstacle>"
  "pure_pursuit/StaticObstacle")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StaticObstacle)))
  "Returns string type for a message object of type 'StaticObstacle"
  "pure_pursuit/StaticObstacle")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StaticObstacle>)))
  "Returns md5sum for a message object of type '<StaticObstacle>"
  "9029ace2c97c95b725648b05842baa15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StaticObstacle)))
  "Returns md5sum for a message object of type 'StaticObstacle"
  "9029ace2c97c95b725648b05842baa15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StaticObstacle>)))
  "Returns full string definition for message of type '<StaticObstacle>"
  (cl:format cl:nil "bool is_static_obs_detected_short~%bool is_static_obs_detected_long~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StaticObstacle)))
  "Returns full string definition for message of type 'StaticObstacle"
  (cl:format cl:nil "bool is_static_obs_detected_short~%bool is_static_obs_detected_long~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StaticObstacle>))
  (cl:+ 0
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StaticObstacle>))
  "Converts a ROS message object to a list"
  (cl:list 'StaticObstacle
    (cl:cons ':is_static_obs_detected_short (is_static_obs_detected_short msg))
    (cl:cons ':is_static_obs_detected_long (is_static_obs_detected_long msg))
))
