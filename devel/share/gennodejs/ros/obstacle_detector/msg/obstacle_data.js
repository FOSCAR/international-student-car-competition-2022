// Auto-generated. Do not edit!

// (in-package obstacle_detector.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class obstacle_data {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.coordinate_x = null;
      this.coordinate_y = null;
      this.coordinate_z = null;
      this.volume = null;
      this.distance = null;
    }
    else {
      if (initObj.hasOwnProperty('coordinate_x')) {
        this.coordinate_x = initObj.coordinate_x
      }
      else {
        this.coordinate_x = 0.0;
      }
      if (initObj.hasOwnProperty('coordinate_y')) {
        this.coordinate_y = initObj.coordinate_y
      }
      else {
        this.coordinate_y = 0.0;
      }
      if (initObj.hasOwnProperty('coordinate_z')) {
        this.coordinate_z = initObj.coordinate_z
      }
      else {
        this.coordinate_z = 0.0;
      }
      if (initObj.hasOwnProperty('volume')) {
        this.volume = initObj.volume
      }
      else {
        this.volume = 0.0;
      }
      if (initObj.hasOwnProperty('distance')) {
        this.distance = initObj.distance
      }
      else {
        this.distance = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type obstacle_data
    // Serialize message field [coordinate_x]
    bufferOffset = _serializer.float64(obj.coordinate_x, buffer, bufferOffset);
    // Serialize message field [coordinate_y]
    bufferOffset = _serializer.float64(obj.coordinate_y, buffer, bufferOffset);
    // Serialize message field [coordinate_z]
    bufferOffset = _serializer.float64(obj.coordinate_z, buffer, bufferOffset);
    // Serialize message field [volume]
    bufferOffset = _serializer.float64(obj.volume, buffer, bufferOffset);
    // Serialize message field [distance]
    bufferOffset = _serializer.float64(obj.distance, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type obstacle_data
    let len;
    let data = new obstacle_data(null);
    // Deserialize message field [coordinate_x]
    data.coordinate_x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [coordinate_y]
    data.coordinate_y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [coordinate_z]
    data.coordinate_z = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [volume]
    data.volume = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [distance]
    data.distance = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 40;
  }

  static datatype() {
    // Returns string type for a message object
    return 'obstacle_detector/obstacle_data';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '55c5c0fa4c104cd9d5bf8f06e255b85f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 coordinate_x
    float64 coordinate_y
    float64 coordinate_z
    float64 volume
    float64 distance
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new obstacle_data(null);
    if (msg.coordinate_x !== undefined) {
      resolved.coordinate_x = msg.coordinate_x;
    }
    else {
      resolved.coordinate_x = 0.0
    }

    if (msg.coordinate_y !== undefined) {
      resolved.coordinate_y = msg.coordinate_y;
    }
    else {
      resolved.coordinate_y = 0.0
    }

    if (msg.coordinate_z !== undefined) {
      resolved.coordinate_z = msg.coordinate_z;
    }
    else {
      resolved.coordinate_z = 0.0
    }

    if (msg.volume !== undefined) {
      resolved.volume = msg.volume;
    }
    else {
      resolved.volume = 0.0
    }

    if (msg.distance !== undefined) {
      resolved.distance = msg.distance;
    }
    else {
      resolved.distance = 0.0
    }

    return resolved;
    }
};

module.exports = obstacle_data;
