; Auto-generated. Do not edit!


(cl:in-package cam_lidar_calibration-srv)


;//! \htmlinclude Optimise-request.msg.html

(cl:defclass <Optimise-request> (roslisp-msg-protocol:ros-message)
  ((operation
    :reader operation
    :initarg :operation
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Optimise-request (<Optimise-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Optimise-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Optimise-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name cam_lidar_calibration-srv:<Optimise-request> is deprecated: use cam_lidar_calibration-srv:Optimise-request instead.")))

(cl:ensure-generic-function 'operation-val :lambda-list '(m))
(cl:defmethod operation-val ((m <Optimise-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cam_lidar_calibration-srv:operation-val is deprecated.  Use cam_lidar_calibration-srv:operation instead.")
  (operation m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Optimise-request>)))
    "Constants for message type '<Optimise-request>"
  '((:READY . 0)
    (:CAPTURE . 1)
    (:DISCARD . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Optimise-request)))
    "Constants for message type 'Optimise-request"
  '((:READY . 0)
    (:CAPTURE . 1)
    (:DISCARD . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Optimise-request>) ostream)
  "Serializes a message object of type '<Optimise-request>"
  (cl:let* ((signed (cl:slot-value msg 'operation)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Optimise-request>) istream)
  "Deserializes a message object of type '<Optimise-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'operation) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Optimise-request>)))
  "Returns string type for a service object of type '<Optimise-request>"
  "cam_lidar_calibration/OptimiseRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Optimise-request)))
  "Returns string type for a service object of type 'Optimise-request"
  "cam_lidar_calibration/OptimiseRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Optimise-request>)))
  "Returns md5sum for a message object of type '<Optimise-request>"
  "6fab8216834f6ade06f14ecf35aff91a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Optimise-request)))
  "Returns md5sum for a message object of type 'Optimise-request"
  "6fab8216834f6ade06f14ecf35aff91a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Optimise-request>)))
  "Returns full string definition for message of type '<Optimise-request>"
  (cl:format cl:nil "int8 operation~%~%int8 READY=0~%int8 CAPTURE=1~%int8 DISCARD=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Optimise-request)))
  "Returns full string definition for message of type 'Optimise-request"
  (cl:format cl:nil "int8 operation~%~%int8 READY=0~%int8 CAPTURE=1~%int8 DISCARD=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Optimise-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Optimise-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Optimise-request
    (cl:cons ':operation (operation msg))
))
;//! \htmlinclude Optimise-response.msg.html

(cl:defclass <Optimise-response> (roslisp-msg-protocol:ros-message)
  ((samples
    :reader samples
    :initarg :samples
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Optimise-response (<Optimise-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Optimise-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Optimise-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name cam_lidar_calibration-srv:<Optimise-response> is deprecated: use cam_lidar_calibration-srv:Optimise-response instead.")))

(cl:ensure-generic-function 'samples-val :lambda-list '(m))
(cl:defmethod samples-val ((m <Optimise-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cam_lidar_calibration-srv:samples-val is deprecated.  Use cam_lidar_calibration-srv:samples instead.")
  (samples m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Optimise-response>) ostream)
  "Serializes a message object of type '<Optimise-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'samples)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Optimise-response>) istream)
  "Deserializes a message object of type '<Optimise-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'samples)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Optimise-response>)))
  "Returns string type for a service object of type '<Optimise-response>"
  "cam_lidar_calibration/OptimiseResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Optimise-response)))
  "Returns string type for a service object of type 'Optimise-response"
  "cam_lidar_calibration/OptimiseResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Optimise-response>)))
  "Returns md5sum for a message object of type '<Optimise-response>"
  "6fab8216834f6ade06f14ecf35aff91a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Optimise-response)))
  "Returns md5sum for a message object of type 'Optimise-response"
  "6fab8216834f6ade06f14ecf35aff91a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Optimise-response>)))
  "Returns full string definition for message of type '<Optimise-response>"
  (cl:format cl:nil "uint8 samples~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Optimise-response)))
  "Returns full string definition for message of type 'Optimise-response"
  (cl:format cl:nil "uint8 samples~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Optimise-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Optimise-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Optimise-response
    (cl:cons ':samples (samples msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Optimise)))
  'Optimise-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Optimise)))
  'Optimise-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Optimise)))
  "Returns string type for a service object of type '<Optimise>"
  "cam_lidar_calibration/Optimise")