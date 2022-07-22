// Auto-generated. Do not edit!

// (in-package pure_pursuit.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class StaticObstacle {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.is_static_obs_detected_short = null;
      this.is_static_obs_detected_long = null;
    }
    else {
      if (initObj.hasOwnProperty('is_static_obs_detected_short')) {
        this.is_static_obs_detected_short = initObj.is_static_obs_detected_short
      }
      else {
        this.is_static_obs_detected_short = false;
      }
      if (initObj.hasOwnProperty('is_static_obs_detected_long')) {
        this.is_static_obs_detected_long = initObj.is_static_obs_detected_long
      }
      else {
        this.is_static_obs_detected_long = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type StaticObstacle
    // Serialize message field [is_static_obs_detected_short]
    bufferOffset = _serializer.bool(obj.is_static_obs_detected_short, buffer, bufferOffset);
    // Serialize message field [is_static_obs_detected_long]
    bufferOffset = _serializer.bool(obj.is_static_obs_detected_long, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type StaticObstacle
    let len;
    let data = new StaticObstacle(null);
    // Deserialize message field [is_static_obs_detected_short]
    data.is_static_obs_detected_short = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [is_static_obs_detected_long]
    data.is_static_obs_detected_long = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 2;
  }

  static datatype() {
    // Returns string type for a message object
    return 'pure_pursuit/StaticObstacle';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9029ace2c97c95b725648b05842baa15';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool is_static_obs_detected_short
    bool is_static_obs_detected_long
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new StaticObstacle(null);
    if (msg.is_static_obs_detected_short !== undefined) {
      resolved.is_static_obs_detected_short = msg.is_static_obs_detected_short;
    }
    else {
      resolved.is_static_obs_detected_short = false
    }

    if (msg.is_static_obs_detected_long !== undefined) {
      resolved.is_static_obs_detected_long = msg.is_static_obs_detected_long;
    }
    else {
      resolved.is_static_obs_detected_long = false
    }

    return resolved;
    }
};

module.exports = StaticObstacle;
