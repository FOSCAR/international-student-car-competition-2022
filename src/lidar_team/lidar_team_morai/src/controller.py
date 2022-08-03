#!/usr/bin/env python
# -*- coding: utf-8 -*-

from curses.ascii import ctrl
import rospy
from lidar_team_morai.msg import CtrlSteering
from lidar_team_morai.msg import CtrlVelocity
from morai_msgs.msg import EgoVehicleStatus, CtrlCmd
import math


class control:
    def __init__(self):
        self.PP_steering = 0.0
        self.DV_velocity = 0.0
        self.flag = 0  # 0 : morai, 1 : real
        print("control mode: ", self.flag)

    def purePursuitCallback(self, data):
        self.PP_steering = data.steering
        self.controlERP42()

    def dynamicVelocityCallback(self, data):
        self.DV_velocity = data.velocity
        self.controlERP42()

    def controlERP42(self):
        if self.flag == 0:
            ctrlMsg = CtrlCmd()
            ctrlMsg.longlCmdType = 2
            ctrlMsg.velocity = self.DV_velocity
            ctrlMsg.steering = self.PP_steering

            velocityPublisher.publish(ctrlMsg)
        else:
            pass


if __name__ == '__main__':
    global ctrlERP42Pub, velocityPublisher
    controller = control()

    rospy.init_node("controller_node")

    rospy.Subscriber("/pure_ctrl_steering", CtrlSteering,
                     controller.purePursuitCallback)
    rospy.Subscriber("/dynamic_ctrl_velocity", CtrlVelocity,
                     controller.dynamicVelocityCallback)

    velocityPublisher = rospy.Publisher(
        "/ctrl_cmd", CtrlCmd, queue_size=1)

    rospy.spin()
