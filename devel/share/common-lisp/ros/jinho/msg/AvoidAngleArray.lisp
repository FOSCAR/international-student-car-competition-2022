; Auto-generated. Do not edit!


(cl:in-package jinho-msg)


;//! \htmlinclude AvoidAngleArray.msg.html

(cl:defclass <AvoidAngleArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (total
    :reader total
    :initarg :total
    :type cl:fixnum
    :initform 0)
   (minAngle
    :reader minAngle
    :initarg :minAngle
    :type (cl:vector cl:float)
   :initform (cl:make-array 20 :element-type 'cl:float :initial-element 0.0))
   (maxAngle
    :reader maxAngle
    :initarg :maxAngle
    :type (cl:vector cl:float)
   :initform (cl:make-array 20 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass AvoidAngleArray (<AvoidAngleArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AvoidAngleArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AvoidAngleArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name jinho-msg:<AvoidAngleArray> is deprecated: use jinho-msg:AvoidAngleArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <AvoidAngleArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader jinho-msg:header-val is deprecated.  Use jinho-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'total-val :lambda-list '(m))
(cl:defmethod total-val ((m <AvoidAngleArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader jinho-msg:total-val is deprecated.  Use jinho-msg:total instead.")
  (total m))

(cl:ensure-generic-function 'minAngle-val :lambda-list '(m))
(cl:defmethod minAngle-val ((m <AvoidAngleArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader jinho-msg:minAngle-val is deprecated.  Use jinho-msg:minAngle instead.")
  (minAngle m))

(cl:ensure-generic-function 'maxAngle-val :lambda-list '(m))
(cl:defmethod maxAngle-val ((m <AvoidAngleArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader jinho-msg:maxAngle-val is deprecated.  Use jinho-msg:maxAngle instead.")
  (maxAngle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AvoidAngleArray>) ostream)
  "Serializes a message object of type '<AvoidAngleArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'total)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'minAngle))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'maxAngle))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AvoidAngleArray>) istream)
  "Deserializes a message object of type '<AvoidAngleArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'total) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  (cl:setf (cl:slot-value msg 'minAngle) (cl:make-array 20))
  (cl:let ((vals (cl:slot-value msg 'minAngle)))
    (cl:dotimes (i 20)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'maxAngle) (cl:make-array 20))
  (cl:let ((vals (cl:slot-value msg 'maxAngle)))
    (cl:dotimes (i 20)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AvoidAngleArray>)))
  "Returns string type for a message object of type '<AvoidAngleArray>"
  "jinho/AvoidAngleArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AvoidAngleArray)))
  "Returns string type for a message object of type 'AvoidAngleArray"
  "jinho/AvoidAngleArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AvoidAngleArray>)))
  "Returns md5sum for a message object of type '<AvoidAngleArray>"
  "175df850181b1f133e7b830da57e6220")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AvoidAngleArray)))
  "Returns md5sum for a message object of type 'AvoidAngleArray"
  "175df850181b1f133e7b830da57e6220")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AvoidAngleArray>)))
  "Returns full string definition for message of type '<AvoidAngleArray>"
  (cl:format cl:nil "Header header~%int8 total~%float64[20] minAngle~%float64[20] maxAngle~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AvoidAngleArray)))
  "Returns full string definition for message of type 'AvoidAngleArray"
  (cl:format cl:nil "Header header~%int8 total~%float64[20] minAngle~%float64[20] maxAngle~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AvoidAngleArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'minAngle) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'maxAngle) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AvoidAngleArray>))
  "Converts a ROS message object to a list"
  (cl:list 'AvoidAngleArray
    (cl:cons ':header (header msg))
    (cl:cons ':total (total msg))
    (cl:cons ':minAngle (minAngle msg))
    (cl:cons ':maxAngle (maxAngle msg))
))
