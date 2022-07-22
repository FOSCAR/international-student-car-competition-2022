// Auto-generated. Do not edit!

// (in-package obstacle_detector.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Boundingbox = require('./Boundingbox.js');

//-----------------------------------------------------------

class Boundingbox_array {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.boundingbox_array = null;
    }
    else {
      if (initObj.hasOwnProperty('boundingbox_array')) {
        this.boundingbox_array = initObj.boundingbox_array
      }
      else {
        this.boundingbox_array = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Boundingbox_array
    // Serialize message field [boundingbox_array]
    // Serialize the length for message field [boundingbox_array]
    bufferOffset = _serializer.uint32(obj.boundingbox_array.length, buffer, bufferOffset);
    obj.boundingbox_array.forEach((val) => {
      bufferOffset = Boundingbox.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Boundingbox_array
    let len;
    let data = new Boundingbox_array(null);
    // Deserialize message field [boundingbox_array]
    // Deserialize array length for message field [boundingbox_array]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.boundingbox_array = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.boundingbox_array[i] = Boundingbox.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 40 * object.boundingbox_array.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'obstacle_detector/Boundingbox_array';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '72f4806878af1954f3e5c66182495641';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Boundingbox[] boundingbox_array
    
    ================================================================================
    MSG: obstacle_detector/Boundingbox
    float64 x
    float64 y
    float64 z
    float64 volume
    float64 distance
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Boundingbox_array(null);
    if (msg.boundingbox_array !== undefined) {
      resolved.boundingbox_array = new Array(msg.boundingbox_array.length);
      for (let i = 0; i < resolved.boundingbox_array.length; ++i) {
        resolved.boundingbox_array[i] = Boundingbox.Resolve(msg.boundingbox_array[i]);
      }
    }
    else {
      resolved.boundingbox_array = []
    }

    return resolved;
    }
};

module.exports = Boundingbox_array;
