#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
# from math import sin, cos, sqrt, pow, atan2, pi
import math
import matplotlib.pyplot as plt
import sys,os
import rospy
import rospkg
from lidar_team_morai.msg import Waypoint
from nav_msgs.msg import Path,Odometry
from std_msgs.msg import Float64,Int16,Float32MultiArray
from geometry_msgs.msg import PoseStamped,Point
from morai_msgs.msg import EgoVehicleStatus,ObjectStatusList,CtrlCmd,GetTrafficLightStatus,SetTrafficLight
import tf

from visualization_msgs.msg import Marker
from visualization_msgs.msg import MarkerArray
from lidar_team_morai.msg import Waypoint
from race.msg import drive_values

# Parameters
k = 0.1  # look forward gain
Lfc = 4.0
# Lfc = 5.0
# Lfc = 1.75
# Lfc = 1.25  # [m] look-ahead distance
Kp = 1.0  # speed proportional gain
dt = 0.1  # [s] time tick
WB = 0.78  # [m] wheel base of vehicle

target_speed = 10
speed = 10
current_v = 10

show_animation = True

# path_x = [0] * 100
# path_y = [0] * 100
path_x = []
path_y = []
current_velocity = 0


class State:

    def __init__(self, x = -0.39, y = 0.0, yaw = 0.0, v = 0.0):
        self.yaw = yaw
        self.v = v
        self.rear_x = x
        self.rear_y = y

    def update(self, a, delta):
        global current_v
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
  
        # To speed up nearest point search, doing it at only first time.  
        if self.old_nearest_point_index is None:
            dx = [state.rear_x - icx for icx in self.cx]
            dy = [state.rear_y - icy for icy in self.cy]
            # print(dx)
            # print(dy)
            d = np.hypot(dx, dy)

            ind = np.argmin(d)
            self.old_nearest_point_index = ind

        else:
            ind = self.old_nearest_point_index

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
        # print(current_v)
        Lf = k * current_v + Lfc  # update look ahead distance
        # Lf = Lfc

        # search look ahead target point index
        while Lf > state.calc_distance(self.cx[ind], self.cy[ind]):
            if (ind + 1) >= len(self.cx):
                break  # not exceed goal
            ind += 1

        print("LF:", Lf)

        return ind, Lf

# def ego_callback(data):
#     global current_velocity
#     current_velocity = data.velocity.x

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

    delta = math.atan2(2.0 * WB * math.sin(alpha) / Lf, 0.75) #/ Lf, 1.4)

    return delta, ind, tx, ty

def path_callback(data):
    global path_x, path_y
    path_x = data.x_arr
    path_y = data.y_arr

# def ego_callback(data):
#     global current_velocity
#     current_velocity = data.velocity.x

if __name__ == '__main__':
    rospy.init_node("pure_pursuit", anonymous=True)

    rospy.Subscriber("/local_path", Waypoint, path_callback) 
    # rospy.Subscriber("/Ego_topic", EgoVehicleStatus, ego_callback)

    #ctrl_pub = rospy.Publisher("/ctrl_cmd", CtrlCmd, queue_size = 1)
    motor_pub = rospy.Publisher("control_value", drive_values, queue_size = 1)
    target_pub = rospy.Publisher('target_point', Marker, queue_size = 1)
    drive_value = drive_values()

    rate = rospy.Rate(30)
    
    # initial state
    state = State(x = -0.92, y = 0.0, yaw = 0.0, v = current_v)

    # target_course = TargetCourse(path_x, path_y)
    # target_ind, _ = target_course.search_target_index(state)
    

    while not rospy.is_shutdown():
        # if sum(path_x) != 0:
        #     print("SUM: ", sum(path_x))
        #     continue
        # else:
        if len(path_x) != 0:
            # print("SUM: ", sum(path_x))
            # Calc control input
            target_course = TargetCourse(path_x, path_y)
            target_ind, _ = target_course.search_target_index(state)
            
            
            # ai = proportional_control(target_speed, current_v)
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
            

            print("di = ", di)
            
            # ctrl_msg.longlCmdType = 2
            # current_v = 0.2 / abs(di)
            if abs(di) > 0.175:
                current_v = 7       #7
            elif abs(di) > 0.08:
                current_v = 9     #12.5
            elif abs(di) > 0.04:
                current_v = 11       #15
            else:
                current_v = 13
            # if abs(di) > 0.2:
            #     current_v = 6.5
            # elif abs(di) > 0.08:
            #     current_v = 8
            # elif abs(di) > 0.04:
            #     current_v = 11
            # else:
            #     current_v = 20
            #if abs(di) > 0.1:
            #    if di > 0: 
            #        di += 0.05 
            #    else:
            #        di -= 0.05
            # ctrl_msg.steering = di 
            # ctrl_msg.velocity = current_v
            # ctrl_pub.publish(ctrl_msg)

            drive_value.throttle = current_v
            drive_value.steering = di * 50

            print(drive_value.throttle)
            motor_pub.publish(drive_value)

            #ai = proportional_control(target_speed, current_v)
            #state.update(ai, di)  # Control vehicle

        rate.sleep()