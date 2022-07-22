#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
from math import sin, cos, sqrt, pow, atan2, pi
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


class purePursuit : ## purePursuit 알고리즘 적용 ##
    def __init__(self):
        self.forward_point=Point()
        self.current_postion=Point()
        self.is_look_forward_point=False
        #self.vehicle_length=2.8
        self.vehicle_length=0.78
        self.lfd = 1
        self.min_lfd=2
        self.max_lfd=10
        self.steering=0
        self.path_x = []
        self.path_y = []

        self.vehicle_yaw = 0.0
        

        rospy.init_node('pure_pursuit', anonymous=True)

        rospy.Subscriber("/Ego_topic", EgoVehicleStatus, self.getEgoStatus)
        rospy.Subscriber("/local_path", Waypoint, self.getPath)

        ctrl_pub = rospy.Publisher('/ctrl_cmd', CtrlCmd, queue_size=1)

        rate = rospy.Rate(30) # 30hz

        while not rospy.is_shutdown():

            self.steering = self.steering_angle()
            
            ctrl_msg = CtrlCmd()
            ctrl_msg.longlCmdType = 2

            ctrl_msg.velocity = 10 #7.5
            ctrl_msg.steering = - self.steering * 0.5 / 28.2 * 3
            #ctrl_msg.steering = 0.5
            print("steering", ctrl_msg.steering)
            ctrl_pub.publish(ctrl_msg)

            rate.sleep()
            #rospy.spin()

    def getPath(self,msg):
        self.path_x = msg.x_arr  #nav_msgs/Path
        self.path_y = msg.y_arr 
        # print(len(self.path_y))

    def getEgoStatus(self,msg):

        self.current_vel=msg.velocity  #kph
        self.vehicle_yaw=0   # rad
        self.current_postion.x=-0.92 ## 차량의 현재x 좌표 ##
        self.current_postion.y=0 ## 차량의 현재y 좌표 ##
        self.current_postion.z=0 ## 차량의 현재z 좌표 ##


    def steering_angle(self): ## purePursuit 알고리즘을 이용한 Steering 계산 ## 
        vehicle_position=self.current_postion
        rotated_point=Point()
        self.is_look_forward_point = False

        for i in range(len(self.path_x)) :
            print("len :", len(self.path_x) )
            dx= self.path_x[i] - vehicle_position.x
            dy= self.path_y[i] - vehicle_position.y
            rotated_point.x = cos(self.vehicle_yaw)*dx + sin(self.vehicle_yaw)*dy
            rotated_point.y = sin(self.vehicle_yaw)*dx - cos(self.vehicle_yaw)*dy
 
            # print("rotated_point :", rotated_point)
            if rotated_point.x >= -0.92 :
                print("len 222 : ", len(rotated_p))
                #print("rotated_point :", rotated_point.x)
                dis=sqrt(pow(rotated_point.x,2)+pow(rotated_point.y,2)) * 3
                # print("dis :", dis)
                if dis >= self.lfd : 
                    
                    self.lfd=self.current_vel.x * 3.6 # 0.65
                    # print("lfd : ", self.lfd)
                    if self.lfd < self.min_lfd : 
                        self.lfd=self.min_lfd
                    elif self.lfd > self.max_lfd :
                        self.lfd=self.max_lfd
                    self.forward_point=(self.path_x[i], self.path_y[i], 0)
                    self.is_look_forward_point=True

                    print("lfd : ", self.lfd)
                    
                    break
            else:
                print("NONONONONONONONONONO")
        
        theta=atan2(rotated_point.y,rotated_point.x)
        print("theta", theta)

        if self.is_look_forward_point :
            self.steering=atan2((2*self.vehicle_length*sin(theta)),self.lfd)*180/pi #deg
            return self.steering ## Steering 반환 ##
        else : 
            print("no found forward point")
            return 0


if __name__ == '__main__':
    try:
        drive=purePursuit()
    except rospy.ROSInterruptException:
        pass