#!/usr/bin/env python
# -*- coding: utf-8 -*-

# from ast import Starred
from decimal import getcontext
import numpy as np
import math
import matplotlib.pyplot as plt
import sys,os
import rospy
import rospkg

from nav_msgs.msg import Path,Odometry
from std_msgs.msg import Float64,Int16,Float32MultiArray
from geometry_msgs.msg import PoseStamped,Point
import tf

from visualization_msgs.msg import Marker
from visualization_msgs.msg import MarkerArray
from lidar_team_erp42.msg import Waypoint
from race.msg import drive_values
from lidar_team_erp42.msg import DynamicVelocity
from vision_distance.msg import ColorconeArray_lidar

# def publishDriveValue(throttle, steering):
#     drive_value.throttle = throttle
#     drive_value.steering = steering
#     motor_pub.publish(drive_value)


def getCone(data):
    global yellow_detection, blue_detection
    yellow_cone = []
    blue_cone = []

    # flag == 0 : yellow / flag == 1 : blue
    for i in range(len(data.colorcone)):
        data.colorcone[i].dist_y = int(data.colorcone[i].dist_y)
        if data.colorcone[i].dist_y < 350:
            if data.colorcone[i].flag == 0:
                yellow_cone.append(data.colorcone[i].dist_y)
            else:
                blue_cone.append(data.colorcone[i].dist_y)

    yellow_cone = sorted(yellow_cone)
    blue_cone = sorted(blue_cone)

    # 왼쪽만 볼 때
    if len(yellow_cone) != 0 and len(blue_cone) == 0:
        yellow_detection = yellow_cone[0]
        blue_detection = None

    # 오른쪽만 볼 때
    elif len(yellow_cone) == 0 and len(blue_cone) != 0:
        yellow_detection = None
        blue_detection = blue_cone[0]

    # 둘 다 볼 때
    else:
        yellow_detection = None
        blue_detection = None

    yellow_cone = []
    blue_cone = []

def angle_cal(dist_y):
    angle = 20 * 240 / dist_y
    return angle

if __name__ == '__main__':
    global yellow_detection, blue_detection

    yellow_detection = None
    blue_detection = None
    realVel = 7
    blue_angle = None
    yellow_angle = None

    rospy.init_node("pure_pursuit", anonymous=True)
    rospy.Subscriber("/color_cone", ColorconeArray_lidar, getCone)

    rate = rospy.Rate(60)
    

    # target_course = TargetCourse(path_x, path_y)
    # target_ind, _ = target_course.search_target_index(state)
    while not rospy.is_shutdown():
        if yellow_detection != None:
            yellow_angle = angle_cal(yellow_detection)
        if blue_detection != None:
            blue_angle = -angle_cal(blue_detection)
        
        print(yellow_detection, blue_detection)

        if yellow_detection == None and blue_detection == None:
            print("straight!!!!!!!!!!!!!!!")

        elif yellow_detection != None and blue_detection == None:
            # publishDriveValue(realVel, yellow_angle)
            print("yellow_angle: ", yellow_angle)
        else:
            # publishDriveValue(realVel, blue_angle)
            print("blue_angle: ", blue_angle)

        rate.sleep()