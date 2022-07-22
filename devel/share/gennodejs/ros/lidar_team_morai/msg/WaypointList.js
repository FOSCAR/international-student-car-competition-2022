// Auto-generated. Do not edit!

// (in-package lidar_team_morai.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Waypoint = require('./Waypoint.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class WaypointList {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.info = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('info')) {
        this.info = initObj.info
      }
      else {
        this.info = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WaypointList
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [info]
    // Serialize the length for message field [info]
    bufferOffset = _serializer.uint32(obj.info.length, buffer, bufferOffset);
    obj.info.forEach((val) => {
      bufferOffset = Waypoint.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WaypointList
    let len;
    let data = new WaypointList(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [info]
    // Deserialize array length for message field [info]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.info = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.info[i] = Waypoint.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 1604 * object.info.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'lidar_team_morai/WaypointList';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5103fdd73a1575a4d565f16f08c82984';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    Waypoint[] info
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
    
    ================================================================================
    MSG: lidar_team_morai/Waypoint
    int32 cnt
    float32[200] x_arr
    float32[200] y_arr
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new WaypointList(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.info !== undefined) {
      resolved.info = new Array(msg.info.length);
      for (let i = 0; i < resolved.info.length; ++i) {
        resolved.info[i] = Waypoint.Resolve(msg.info[i]);
      }
    }
    else {
      resolved.info = []
    }

    return resolved;
    }
};

module.exports = WaypointList;
