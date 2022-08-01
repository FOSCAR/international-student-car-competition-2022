#!/usr/bin/env python
# -*- coding: utf-8 -*-
import tf
import sys,os
import rospy
import math, time
from ar_track_alvar_msgs.msg import AlvarMarkers
from tf.transformations import euler_from_quaternion
from geometry_msgs.msg import PoseStamped

arData = {"AX": 0.0, "AY": 0.0, "AZ": 0.0, "AW": 0.0}

def callback(msg):
    global arData

    # for i in range(4):
    #     arData["AX"] = msg.pose.
    #     arData["AY"] = i.y
    #     arData["AZ"] = i.z
    #     arData["AW"] = i.w
    #     print(i)
    arData["AX"] = msg.pose.orientation.x
    arData["AY"] = msg.pose.orientation.y
    arData["AZ"] = msg.pose.orientation.z
    arData["AW"] = msg.pose.orientation.w
    # print(msg.pose.orientation)
    # print(msg.pose.orientation)
    # print("############")

if __name__ == '__main__':
    rospy.init_node('path_reader', anonymous=True)
    rospy.Subscriber("current_pose", PoseStamped, callback)

    rate = rospy.Rate(60)

    while not rospy.is_shutdown():

        (roll, pitch, yaw)=euler_from_quaternion((arData["AX"], arData["AY"], arData["AZ"], arData["AW"]))
        # (roll, pitch, yaw)=euler_from_quaternion((0, 0, 2, 3))
        roll = math.degrees(roll)
        pitch = math.degrees(pitch)
        yaw = math.degrees(yaw)
        
        print("roll: ", roll)
        print("pitch: ", pitch)
        print("yaw: ", yaw)
        rate.sleep()
    