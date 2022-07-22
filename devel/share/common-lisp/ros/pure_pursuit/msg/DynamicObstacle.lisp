; Auto-generated. Do not edit!


(cl:in-package pure_pursuit-msg)


;//! \htmlinclude DynamicObstacle.msg.html

(cl:defclass <DynamicObstacle> (roslisp-msg-protocol:ros-message)
  ((is_dynamic_obs_detected_short
    :reader is_dynamic_obs_detected_short
    :initarg :is_dynamic_obs_detected_short
    :type cl:boolean
    :initform cl:nil)
   (is_dynamic_obs_detected_long
    :reader is_dynamic_obs_detected_long
    :initarg :is_dynamic_obs_detected_long
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass DynamicObstacle (<DynamicObstacle>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DynamicObstacle>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DynamicObstacle)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name pure_pursuit-msg:<DynamicObstacle> is deprecated: use pure_pursuit-msg:DynamicObstacle instead.")))

(cl:ensure-generic-function 'is_dynamic_obs_detected_short-val :lambda-list '(m))
(cl:defmethod is_dynamic_obs_detected_short-val ((m <DynamicObstacle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pure_pursuit-msg:is_dynamic_obs_detected_short-val is deprecated.  Use pure_pursuit-msg:is_dynamic_obs_detected_short instead.")
  (is_dynamic_obs_detected_short m))

(cl:ensure-generic-function 'is_dynamic_obs_detected_long-val :lambda-list '(m))
(cl:defmethod is_dynamic_obs_detected_long-val ((m <DynamicObstacle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pure_pursuit-msg:is_dynamic_obs_detected_long-val is deprecated.  Use pure_pursuit-msg:is_dynamic_obs_detected_long instead.")
  (is_dynamic_obs_detected_long m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DynamicObstacle>) ostream)
  "Serializes a message object of type '<DynamicObstacle>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_dynamic_obs_detected_short) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_dynamic_obs_detected_long) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DynamicObstacle>) istream)
  "Deserializes a message object of type '<DynamicObstacle>"
    (cl:setf (cl:slot-value msg 'is_dynamic_obs_detected_short) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'is_dynamic_obs_detected_long) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DynamicObstacle>)))
  "Returns string type for a message object of type '<DynamicObstacle>"
  "pure_pursuit/DynamicObstacle")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DynamicObstacle)))
  "Returns string type for a message object of type 'DynamicObstacle"
  "pure_pursuit/DynamicObstacle")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DynamicObstacle>)))
  "Returns md5sum for a message object of type '<DynamicObstacle>"
  "c882ecd689b24462667336642ad7283e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DynamicObstacle)))
  "Returns md5sum for a message object of type 'DynamicObstacle"
  "c882ecd689b24462667336642ad7283e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DynamicObstacle>)))
  "Returns full string definition for message of type '<DynamicObstacle>"
  (cl:format cl:nil "bool is_dynamic_obs_detected_short~%bool is_dynamic_obs_detected_long~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DynamicObstacle)))
  "Returns full string definition for message of type 'DynamicObstacle"
  (cl:format cl:nil "bool is_dynamic_obs_detected_short~%bool is_dynamic_obs_detected_long~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DynamicObstacle>))
  (cl:+ 0
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DynamicObstacle>))
  "Converts a ROS message object to a list"
  (cl:list 'DynamicObstacle
    (cl:cons ':is_dynamic_obs_detected_short (is_dynamic_obs_detected_short msg))
    (cl:cons ':is_dynamic_obs_detected_long (is_dynamic_obs_detected_long msg))
))
