// Auto-generated. Do not edit!

// (in-package cam_lidar_calibration.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class OptimiseRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.operation = null;
    }
    else {
      if (initObj.hasOwnProperty('operation')) {
        this.operation = initObj.operation
      }
      else {
        this.operation = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OptimiseRequest
    // Serialize message field [operation]
    bufferOffset = _serializer.int8(obj.operation, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OptimiseRequest
    let len;
    let data = new OptimiseRequest(null);
    // Deserialize message field [operation]
    data.operation = _deserializer.int8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'cam_lidar_calibration/OptimiseRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2d3087f8d04e889cffaae0e602f2d205';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int8 operation
    
    int8 READY=0
    int8 CAPTURE=1
    int8 DISCARD=2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new OptimiseRequest(null);
    if (msg.operation !== undefined) {
      resolved.operation = msg.operation;
    }
    else {
      resolved.operation = 0
    }

    return resolved;
    }
};

// Constants for message
OptimiseRequest.Constants = {
  READY: 0,
  CAPTURE: 1,
  DISCARD: 2,
}

class OptimiseResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.samples = null;
    }
    else {
      if (initObj.hasOwnProperty('samples')) {
        this.samples = initObj.samples
      }
      else {
        this.samples = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OptimiseResponse
    // Serialize message field [samples]
    bufferOffset = _serializer.uint8(obj.samples, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OptimiseResponse
    let len;
    let data = new OptimiseResponse(null);
    // Deserialize message field [samples]
    data.samples = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'cam_lidar_calibration/OptimiseResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f73727291f76ef81a996e00ff082aa18';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 samples
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new OptimiseResponse(null);
    if (msg.samples !== undefined) {
      resolved.samples = msg.samples;
    }
    else {
      resolved.samples = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: OptimiseRequest,
  Response: OptimiseResponse,
  md5sum() { return '6fab8216834f6ade06f14ecf35aff91a'; },
  datatype() { return 'cam_lidar_calibration/Optimise'; }
};
