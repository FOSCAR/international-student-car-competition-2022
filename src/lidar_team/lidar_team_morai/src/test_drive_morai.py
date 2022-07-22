#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys,os
import rospy
import rospkg
import numpy as np
from lidar_team_morai.msg import Waypoint
from nav_msgs.msg import Path,Odometry
from std_msgs.msg import Float64,Int16,Float32MultiArray
from geometry_msgs.msg import PoseStamped,Point
from morai_msgs.msg import EgoVehicleStatus,ObjectStatusList,CtrlCmd,GetTrafficLightStatus,SetTrafficLight
import tf
from math import cos, sin, sqrt, pow, atan2, pi

# from utils import cruiseControl, pidController, velocityPlanning

angle = 0
pre_data = 0

class drive():
    def __init__(self):
        global angle
        rospy.init_node('morai_drive', anonymous=True)
        
        #publisher
        ctrl_pub = rospy.Publisher('/ctrl_cmd',CtrlCmd, queue_size=1)

        ctrl_msg= CtrlCmd()
        # self.cc=cruiseControl(0.5,1)
        # pid=pidController()    
        
        #subscriber
        rospy.Subscriber("/Ego_topic", EgoVehicleStatus, self.statusCB)
        # rospy.Subscriber("/waypoint_position", Waypoint, self.waypoint_callback)

        self.status_msg=EgoVehicleStatus()

        # vel_planner=velocityPlanning(60/3.6,1.5)
        # vel_profile=vel_planner.curveBasedVelocity(self.global_path,100)


        rate = rospy.Rate(30)
        ctrl_msg.longCmdType = 2
        while not rospy.is_shutdown():
            
            # velocity max : 23.38 km/h
            # ctrl_msg.velocity = 10
            # self.status_msg.velocity.x = 100
            # 22.3(speed) --> 6.2 (velocity.x)

            # + : left, - : right
            # 0.1(user) --> 5.7(car)
            # steering max : 0.5 --> 28.2
            
            # ctrl_msg.accel = 1
            ctrl_msg.velocity = 16.0
            ctrl_msg.steering = 0.1
            # ctrl_msg.steering = angle


            # cc_vel = self.cc.acc(local_obj,self.status_msg.velocity.x,vel_profile[self.current_waypoint],self.status_msg)
            
            # target_velocity = 6.2
            # ctrl_msg.velocity = cc_vel

            # error = target_velocity - status_msg.velocity.x
            # control_input=pid.pid(target_velocity,self.status_msg.velocity) ## 속도 제어를 위한 PID 적용 (target Velocity, Status Velocity)
            
            # print("==========================")
            # print("current speed : ", self.status_msg.velocity.x)
            # print("target speed : ", target_velocity)
            # print("control_input : ", control_input)

            # if control_input > 0 :
            #     ctrl_msg.accel= control_input
            #     ctrl_msg.brake= 0

            # else :
            #     ctrl_msg.accel= 0
            #     ctrl_msg.brake= -control_inputctrl_msg.velocity
            #     ctrl_msg.brake=1

            ctrl_pub.publish(ctrl_msg)

            rate.sleep()

    # def waypoint_callback(self, data):
    #     global angle
    #     global pre_data

    #     # if pre_data == data.x:
    #     #     print("bad\n")
    #     # else:
    #     #     print("good\n")

    #     angle = atan2(data.x, data.y) / pi * 0.5 * 0.1

    #     if ( 1 < abs(data.y) ):
    #         angle = angle * 7

    #     if (data.y < 0):
    #         angle = angle * -1
        
    #     pre_data = data.x

        # print ("DAYA.Y: ", data.y)
        # print ('\n')
        # print ("ANGLE: ", angle)
        # print ('\n')

        
    def statusCB(self,data):
        self.status_msg=EgoVehicleStatus()
        self.status_msg=data
        br = tf.TransformBroadcaster()
        br.sendTransform((self.status_msg.position.x, self.status_msg.position.y, self.status_msg.position.z),
                        tf.transformations.quaternion_from_euler(0, 0, self.status_msg.heading/180*pi),
                        rospy.Time.now(),
                        "gps",
                        "map")
        self.is_status=True

if __name__ == '__main__':
    try:
        drive = drive()
    except rospy.ROSInterruptException:
        pass

