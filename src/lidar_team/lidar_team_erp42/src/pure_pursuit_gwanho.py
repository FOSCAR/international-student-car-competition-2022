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

# Parameters
k = 0.3  # look forward gain
Lfc = 3.0
# Lfc = 5.0
# Lfc = 1.75
# Lfc = 1.25  # [m] look-ahead distance
Kp = 1.0  # speed proportional gain
dt = 0.1  # [s] time tick
WB = 1.04  # [m] wheel base of vehicle

target_speed = 10
speed = 10

show_animation = True

# path_x = [0] * 100
# path_y = [0] * 100
path_x = []
path_y = []
current_velocity = 0


class State:

    def __init__(self, x = -1.1, y = 0.0, yaw = 0.0, v = 0.0):
        self.yaw = yaw
        self.v = v
        self.rear_x = x
        self.rear_y = y

    def update(self, a, delta):
        global realVel
        self.v += a * dt

    def calc_distance(self, point_x, point_y):
        dx = self.rear_x - point_x
        dy = self.rear_y - point_y
        # print(math.hypot(dx, dy))
        return math.hypot(dx, dy)


def proportional_control(target, current):
    a = Kp * (target - current)

    return a


class TargetCourse:

    def __init__(self, cx, cy):
        self.cx = cx
        self.cy = cy
        self.old_nearest_point_index = None
 

    def search_target_index(self, state):
        global realVel
        # To speed up nearest point search, doing it at only first time.  
        if self.old_nearest_point_index is None:
            # search nearest point index
            # print(path_x)
            dx = [state.rear_x - icx for icx in self.cx]
            dy = [state.rear_y - icy for icy in self.cy]
            # print(dx)
            # print(dy)
            d = np.hypot(dx, dy)

            ind = np.argmin(d)
            self.old_nearest_point_index = ind
        else:
            ind = self.old_nearest_point_index
            # print("ind:", ind)
            # print("CX!!!!!!!!!!!!!!!!!!: ", self.cx)
            distance_this_index = state.calc_distance(self.cx[ind], self.cy[ind])
            while True:
                distance_next_index = state.calc_distance(self.cx[ind + 1], self.cy[ind + 1])

                if distance_this_index < distance_next_index + 1:
                    break
                
                if (ind + 1) < len(self.cx):
                    ind = ind + 1
                else:
                    ind = ind 
                # ind = ind + 1 if (ind + 1) < len(self.cx) else ind
                distance_this_index = distance_next_index
            self.old_nearest_point_index = ind

        
        # print(state.v)
        # print(realVel)
        Lf = k * realVel + Lfc  # update look ahead distance
        # Lf = Lfc

        # search look ahead target point index
        while Lf > state.calc_distance(self.cx[ind], self.cy[ind]):
            if (ind + 1) >= len(self.cx):
                break  # not exceed goal
            ind += 1

        print("LF:", Lf)

        return ind, Lf


def pure_pursuit_steer_control(state, trajectory, pind):
    ind, Lf = trajectory.search_target_index(state)

    if pind >= ind:
        ind = pind

    if ind < len(trajectory.cx):
        tx = trajectory.cx[ind]
        ty = trajectory.cy[ind]
    else:  # toward goal
        tx = trajectory.cx[-1]
        ty = trajectory.cy[-1]
        ind = len(trajectory.cx) - 1

    alpha = math.atan2(ty - state.rear_y, tx - state.rear_x) - state.yaw

    delta = math.atan2(2.0 * WB * math.sin(alpha) / Lf, 0.7) * 100 #/ Lf, 1.4)


    return delta, ind, tx, ty

def path_callback(data):
    global path_x, path_y
    path_x = data.x_arr
    path_y = data.y_arr

def ego_callback(data):
    global current_velocity
    current_velocity = data.velocity.x

def publishDriveValue(throttle, steering):
    drive_value.throttle = throttle
    drive_value.steering = steering
    motor_pub.publish(drive_value)

def getVelocity(data):
    global realVel
    # print("test")
    realVel = data.throttle

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
    blue_angle = 0
    yellow_angle = 0

    rospy.init_node("pure_pursuit", anonymous=True)

    rospy.Subscriber("/local_path", Waypoint, path_callback)
    rospy.Subscriber("/dynamic_velocity", DynamicVelocity, getVelocity)
    rospy.Subscriber("/color_cone", ColorconeArray_lidar, getCone)

    motor_pub = rospy.Publisher("/control_value", drive_values, queue_size = 1)
    target_pub = rospy.Publisher("/target_point", Marker, queue_size = 1)
    drive_value = drive_values()

    rate = rospy.Rate(60)
    
    # initial state
    state = State(x = -1.1, y = 0.0, yaw = 0.0, v = realVel)

    # target_course = TargetCourse(path_x, path_y)
    # target_ind, _ = target_course.search_target_index(state)
    while not rospy.is_shutdown():
        if len(path_x) != 0:  
            if yellow_detection != None:
                yellow_angle = angle_cal(yellow_detection)
            if blue_detection != None:
                blue_angle = -angle_cal(blue_detection)
                
            if yellow_detection == None and blue_detection == None:
                # Calc control input
                target_course = TargetCourse(path_x, path_y)
                target_ind, _ = target_course.search_target_index(state)
                
                # ai = proportional_control(target_speed, realVel)
                di, target_ind, target_x, target_y = pure_pursuit_steer_control(state, target_course, target_ind)
                # state.update(ai, di)  # Control vehicle

                marker = Marker()
                marker.header.frame_id = "/velodyne"
                marker.id = 1004
                marker.type = marker.SPHERE
                marker.action = marker.ADD
                marker.scale.x = 1.05
                marker.scale.y = 1.05
                marker.scale.z = 1.05
                marker.color.a = 1.0
                marker.color.r = 1.0
                marker.color.g = 0.0
                marker.color.b = 1.0
                marker.pose.orientation.w = 1.0
                marker.pose.position.x = target_x
                marker.pose.position.y = target_y
                marker.pose.position.z = 0.2

                marker.lifetime = rospy.Duration(0.1)

                target_pub.publish(marker)
            
                publishDriveValue(realVel, -di)

                ai = proportional_control(target_speed, realVel)
                state.update(ai, di)  # Control vehicle
                print("straight!!!!!!!!!!!!!!!")

            elif yellow_detection != None and blue_detection == None:
                publishDriveValue(realVel, yellow_angle)
                print("yellow_angle: ", yellow_angle)
            else:
                publishDriveValue(realVel, blue_angle)
                print("blue_angle: ", blue_angle)

        rate.sleep()