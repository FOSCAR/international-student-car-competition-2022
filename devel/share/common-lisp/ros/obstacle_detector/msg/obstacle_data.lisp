; Auto-generated. Do not edit!


(cl:in-package obstacle_detector-msg)


;//! \htmlinclude obstacle_data.msg.html

(cl:defclass <obstacle_data> (roslisp-msg-protocol:ros-message)
  ((coordinate_x
    :reader coordinate_x
    :initarg :coordinate_x
    :type cl:float
    :initform 0.0)
   (coordinate_y
    :reader coordinate_y
    :initarg :coordinate_y
    :type cl:float
    :initform 0.0)
   (coordinate_z
    :reader coordinate_z
    :initarg :coordinate_z
    :type cl:float
    :initform 0.0)
   (volume
    :reader volume
    :initarg :volume
    :type cl:float
    :initform 0.0)
   (distance
    :reader distance
    :initarg :distance
    :type cl:float
    :initform 0.0))
)

(cl:defclass obstacle_data (<obstacle_data>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <obstacle_data>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'obstacle_data)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name obstacle_detector-msg:<obstacle_data> is deprecated: use obstacle_detector-msg:obstacle_data instead.")))

(cl:ensure-generic-function 'coordinate_x-val :lambda-list '(m))
(cl:defmethod coordinate_x-val ((m <obstacle_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader obstacle_detector-msg:coordinate_x-val is deprecated.  Use obstacle_detector-msg:coordinate_x instead.")
  (coordinate_x m))

(cl:ensure-generic-function 'coordinate_y-val :lambda-list '(m))
(cl:defmethod coordinate_y-val ((m <obstacle_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader obstacle_detector-msg:coordinate_y-val is deprecated.  Use obstacle_detector-msg:coordinate_y instead.")
  (coordinate_y m))

(cl:ensure-generic-function 'coordinate_z-val :lambda-list '(m))
(cl:defmethod coordinate_z-val ((m <obstacle_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader obstacle_detector-msg:coordinate_z-val is deprecated.  Use obstacle_detector-msg:coordinate_z instead.")
  (coordinate_z m))

(cl:ensure-generic-function 'volume-val :lambda-list '(m))
(cl:defmethod volume-val ((m <obstacle_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader obstacle_detector-msg:volume-val is deprecated.  Use obstacle_detector-msg:volume instead.")
  (volume m))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <obstacle_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader obstacle_detector-msg:distance-val is deprecated.  Use obstacle_detector-msg:distance instead.")
  (distance m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <obstacle_data>) ostream)
  "Serializes a message object of type '<obstacle_data>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'coordinate_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'coordinate_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'coordinate_z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'volume))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <obstacle_data>) istream)
  "Deserializes a message object of type '<obstacle_data>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'coordinate_x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'coordinate_y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'coordinate_z) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'volume) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<obstacle_data>)))
  "Returns string type for a message object of type '<obstacle_data>"
  "obstacle_detector/obstacle_data")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'obstacle_data)))
  "Returns string type for a message object of type 'obstacle_data"
  "obstacle_detector/obstacle_data")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<obstacle_data>)))
  "Returns md5sum for a message object of type '<obstacle_data>"
  "55c5c0fa4c104cd9d5bf8f06e255b85f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'obstacle_data)))
  "Returns md5sum for a message object of type 'obstacle_data"
  "55c5c0fa4c104cd9d5bf8f06e255b85f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<obstacle_data>)))
  "Returns full string definition for message of type '<obstacle_data>"
  (cl:format cl:nil "float64 coordinate_x~%float64 coordinate_y~%float64 coordinate_z~%float64 volume~%float64 distance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'obstacle_data)))
  "Returns full string definition for message of type 'obstacle_data"
  (cl:format cl:nil "float64 coordinate_x~%float64 coordinate_y~%float64 coordinate_z~%float64 volume~%float64 distance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <obstacle_data>))
  (cl:+ 0
     8
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <obstacle_data>))
  "Converts a ROS message object to a list"
  (cl:list 'obstacle_data
    (cl:cons ':coordinate_x (coordinate_x msg))
    (cl:cons ':coordinate_y (coordinate_y msg))
    (cl:cons ':coordinate_z (coordinate_z msg))
    (cl:cons ':volume (volume msg))
    (cl:cons ':distance (distance msg))
))
