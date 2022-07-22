; Auto-generated. Do not edit!


(cl:in-package obstacle_detector-msg)


;//! \htmlinclude Boundingbox_array.msg.html

(cl:defclass <Boundingbox_array> (roslisp-msg-protocol:ros-message)
  ((boundingbox_array
    :reader boundingbox_array
    :initarg :boundingbox_array
    :type (cl:vector obstacle_detector-msg:Boundingbox)
   :initform (cl:make-array 0 :element-type 'obstacle_detector-msg:Boundingbox :initial-element (cl:make-instance 'obstacle_detector-msg:Boundingbox))))
)

(cl:defclass Boundingbox_array (<Boundingbox_array>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Boundingbox_array>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Boundingbox_array)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name obstacle_detector-msg:<Boundingbox_array> is deprecated: use obstacle_detector-msg:Boundingbox_array instead.")))

(cl:ensure-generic-function 'boundingbox_array-val :lambda-list '(m))
(cl:defmethod boundingbox_array-val ((m <Boundingbox_array>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader obstacle_detector-msg:boundingbox_array-val is deprecated.  Use obstacle_detector-msg:boundingbox_array instead.")
  (boundingbox_array m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Boundingbox_array>) ostream)
  "Serializes a message object of type '<Boundingbox_array>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'boundingbox_array))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'boundingbox_array))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Boundingbox_array>) istream)
  "Deserializes a message object of type '<Boundingbox_array>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'boundingbox_array) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'boundingbox_array)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'obstacle_detector-msg:Boundingbox))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Boundingbox_array>)))
  "Returns string type for a message object of type '<Boundingbox_array>"
  "obstacle_detector/Boundingbox_array")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Boundingbox_array)))
  "Returns string type for a message object of type 'Boundingbox_array"
  "obstacle_detector/Boundingbox_array")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Boundingbox_array>)))
  "Returns md5sum for a message object of type '<Boundingbox_array>"
  "72f4806878af1954f3e5c66182495641")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Boundingbox_array)))
  "Returns md5sum for a message object of type 'Boundingbox_array"
  "72f4806878af1954f3e5c66182495641")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Boundingbox_array>)))
  "Returns full string definition for message of type '<Boundingbox_array>"
  (cl:format cl:nil "Boundingbox[] boundingbox_array~%~%================================================================================~%MSG: obstacle_detector/Boundingbox~%float64 x~%float64 y~%float64 z~%float64 volume~%float64 distance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Boundingbox_array)))
  "Returns full string definition for message of type 'Boundingbox_array"
  (cl:format cl:nil "Boundingbox[] boundingbox_array~%~%================================================================================~%MSG: obstacle_detector/Boundingbox~%float64 x~%float64 y~%float64 z~%float64 volume~%float64 distance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Boundingbox_array>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'boundingbox_array) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Boundingbox_array>))
  "Converts a ROS message object to a list"
  (cl:list 'Boundingbox_array
    (cl:cons ':boundingbox_array (boundingbox_array msg))
))
