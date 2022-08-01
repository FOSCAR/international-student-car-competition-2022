// Auto-generated. Do not edit!

// (in-package jinho.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class AvoidAngleArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.total = null;
      this.minAngle = null;
      this.maxAngle = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('total')) {
        this.total = initObj.total
      }
      else {
        this.total = 0;
      }
      if (initObj.hasOwnProperty('minAngle')) {
        this.minAngle = initObj.minAngle
      }
      else {
        this.minAngle = new Array(20).fill(0);
      }
      if (initObj.hasOwnProperty('maxAngle')) {
        this.maxAngle = initObj.maxAngle
      }
      else {
        this.maxAngle = new Array(20).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AvoidAngleArray
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [total]
    bufferOffset = _serializer.int8(obj.total, buffer, bufferOffset);
    // Check that the constant length array field [minAngle] has the right length
    if (obj.minAngle.length !== 20) {
      throw new Error('Unable to serialize array field minAngle - length must be 20')
    }
    // Serialize message field [minAngle]
    bufferOffset = _arraySerializer.float64(obj.minAngle, buffer, bufferOffset, 20);
    // Check that the constant length array field [maxAngle] has the right length
    if (obj.maxAngle.length !== 20) {
      throw new Error('Unable to serialize array field maxAngle - length must be 20')
    }
    // Serialize message field [maxAngle]
    bufferOffset = _arraySerializer.float64(obj.maxAngle, buffer, bufferOffset, 20);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AvoidAngleArray
    let len;
    let data = new AvoidAngleArray(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [total]
    data.total = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [minAngle]
    data.minAngle = _arrayDeserializer.float64(buffer, bufferOffset, 20)
    // Deserialize message field [maxAngle]
    data.maxAngle = _arrayDeserializer.float64(buffer, bufferOffset, 20)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 321;
  }

  static datatype() {
    // Returns string type for a message object
    return 'jinho/AvoidAngleArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '175df850181b1f133e7b830da57e6220';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    int8 total
    float64[20] minAngle
    float64[20] maxAngle
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AvoidAngleArray(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.total !== undefined) {
      resolved.total = msg.total;
    }
    else {
      resolved.total = 0
    }

    if (msg.minAngle !== undefined) {
      resolved.minAngle = msg.minAngle;
    }
    else {
      resolved.minAngle = new Array(20).fill(0)
    }

    if (msg.maxAngle !== undefined) {
      resolved.maxAngle = msg.maxAngle;
    }
    else {
      resolved.maxAngle = new Array(20).fill(0)
    }

    return resolved;
    }
};

module.exports = AvoidAngleArray;
