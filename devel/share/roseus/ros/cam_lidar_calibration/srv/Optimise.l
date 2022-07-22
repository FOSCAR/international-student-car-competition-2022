;; Auto-generated. Do not edit!


(when (boundp 'cam_lidar_calibration::Optimise)
  (if (not (find-package "CAM_LIDAR_CALIBRATION"))
    (make-package "CAM_LIDAR_CALIBRATION"))
  (shadow 'Optimise (find-package "CAM_LIDAR_CALIBRATION")))
(unless (find-package "CAM_LIDAR_CALIBRATION::OPTIMISE")
  (make-package "CAM_LIDAR_CALIBRATION::OPTIMISE"))
(unless (find-package "CAM_LIDAR_CALIBRATION::OPTIMISEREQUEST")
  (make-package "CAM_LIDAR_CALIBRATION::OPTIMISEREQUEST"))
(unless (find-package "CAM_LIDAR_CALIBRATION::OPTIMISERESPONSE")
  (make-package "CAM_LIDAR_CALIBRATION::OPTIMISERESPONSE"))

(in-package "ROS")





(intern "*READY*" (find-package "CAM_LIDAR_CALIBRATION::OPTIMISEREQUEST"))
(shadow '*READY* (find-package "CAM_LIDAR_CALIBRATION::OPTIMISEREQUEST"))
(defconstant cam_lidar_calibration::OptimiseRequest::*READY* 0)
(intern "*CAPTURE*" (find-package "CAM_LIDAR_CALIBRATION::OPTIMISEREQUEST"))
(shadow '*CAPTURE* (find-package "CAM_LIDAR_CALIBRATION::OPTIMISEREQUEST"))
(defconstant cam_lidar_calibration::OptimiseRequest::*CAPTURE* 1)
(intern "*DISCARD*" (find-package "CAM_LIDAR_CALIBRATION::OPTIMISEREQUEST"))
(shadow '*DISCARD* (find-package "CAM_LIDAR_CALIBRATION::OPTIMISEREQUEST"))
(defconstant cam_lidar_calibration::OptimiseRequest::*DISCARD* 2)
(defclass cam_lidar_calibration::OptimiseRequest
  :super ros::object
  :slots (_operation ))

(defmethod cam_lidar_calibration::OptimiseRequest
  (:init
   (&key
    ((:operation __operation) 0)
    )
   (send-super :init)
   (setq _operation (round __operation))
   self)
  (:operation
   (&optional __operation)
   (if __operation (setq _operation __operation)) _operation)
  (:serialization-length
   ()
   (+
    ;; int8 _operation
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _operation
       (write-byte _operation s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _operation
     (setq _operation (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _operation 127) (setq _operation (- _operation 256)))
   ;;
   self)
  )

(defclass cam_lidar_calibration::OptimiseResponse
  :super ros::object
  :slots (_samples ))

(defmethod cam_lidar_calibration::OptimiseResponse
  (:init
   (&key
    ((:samples __samples) 0)
    )
   (send-super :init)
   (setq _samples (round __samples))
   self)
  (:samples
   (&optional __samples)
   (if __samples (setq _samples __samples)) _samples)
  (:serialization-length
   ()
   (+
    ;; uint8 _samples
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _samples
       (write-byte _samples s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _samples
     (setq _samples (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass cam_lidar_calibration::Optimise
  :super ros::object
  :slots ())

(setf (get cam_lidar_calibration::Optimise :md5sum-) "6fab8216834f6ade06f14ecf35aff91a")
(setf (get cam_lidar_calibration::Optimise :datatype-) "cam_lidar_calibration/Optimise")
(setf (get cam_lidar_calibration::Optimise :request) cam_lidar_calibration::OptimiseRequest)
(setf (get cam_lidar_calibration::Optimise :response) cam_lidar_calibration::OptimiseResponse)

(defmethod cam_lidar_calibration::OptimiseRequest
  (:response () (instance cam_lidar_calibration::OptimiseResponse :init)))

(setf (get cam_lidar_calibration::OptimiseRequest :md5sum-) "6fab8216834f6ade06f14ecf35aff91a")
(setf (get cam_lidar_calibration::OptimiseRequest :datatype-) "cam_lidar_calibration/OptimiseRequest")
(setf (get cam_lidar_calibration::OptimiseRequest :definition-)
      "int8 operation

int8 READY=0
int8 CAPTURE=1
int8 DISCARD=2
---
uint8 samples

")

(setf (get cam_lidar_calibration::OptimiseResponse :md5sum-) "6fab8216834f6ade06f14ecf35aff91a")
(setf (get cam_lidar_calibration::OptimiseResponse :datatype-) "cam_lidar_calibration/OptimiseResponse")
(setf (get cam_lidar_calibration::OptimiseResponse :definition-)
      "int8 operation

int8 READY=0
int8 CAPTURE=1
int8 DISCARD=2
---
uint8 samples

")



(provide :cam_lidar_calibration/Optimise "6fab8216834f6ade06f14ecf35aff91a")


