#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math
import rospy
from geometry_msgs.msg import TwistWithCovarianceStamped
from track_race.msg import Test as TestMsg
from std_msgs.msg import Float64
from visualization_msgs.msg import Marker
from geometry_msgs.msg import Point
from std_msgs.msg import ColorRGBA
from race.msg import drive_values

class Test:
    def __init__(self):
        self.speedMsg = Float64()
        self.speed = 0.0
        self.xVelocity = 0.0
        self.yVelocity = 0.0
        self.zVelocity = 0.0
        self.sec = 0
        self.nsec = 0
        self.timeDelta = 0.0
        self.weight = 2
        self.displacement = 0.0
        self.distance = 0.0
        self.maxDist = 5.0
        self.xDistance = 0.0
        self.yDistance = 0.0
        self.zDistance = 0.0


        # self.startFlag = True

        self.ctrlMsg = drive_values()

        # Subscribe
        rospy.Subscriber("/gps_front/fix_velocity", TwistWithCovarianceStamped, self.mainCallback)

        # Publisher
        self.ctrlMsgPublisher = rospy.Publisher("/control_value", drive_values, queue_size=1)

    
    def mainCallback(self, msg):
        self.setData(msg)
        self.calcVelocity()
        

    def setData(self, msg):
        self.xVelocity = msg.twist.twist.linear.x
        self.yVelocity = msg.twist.twist.linear.y
        self.zVelocity = msg.twist.twist.linear.z

        self.speed = math.sqrt(
            self.xVelocity * self.xVelocity +
            self.yVelocity * self.yVelocity +
            self.zVelocity * self.zVelocity
        )
        
        if self.sec == 0:
            self.sec = msg.header.stamp.secs
            self.nsec = msg.header.stamp.nsecs
            return
        deltaSec = msg.header.stamp.secs - self.sec
        deltaNSec = (msg.header.stamp.nsecs - self.nsec) / 1000000000.0
        self.timeDelta = deltaSec + deltaNSec
    

        self.sec = msg.header.stamp.secs
        self.nsec = msg.header.stamp.nsecs
        
    def calcVelocity(self):  
        self.xDistance += self.timeDelta * self.xVelocity
        self.yDistance += self.timeDelta * self.yVelocity
        self.zDistance += self.timeDelta * self.zVelocity

        self.displacement = math.sqrt(self.xDistance * self.xDistance + self.yDistance * self.yDistance + self.zDistance * self.zDistance)
        self.distance += self.speed * self.timeDelta

        print("delta Time:", self.timeDelta)
        print("distance :", self.distance)
        print("displacement :", self.displacement)
        

    def goStraight(self):
        self.ctrlMsg.throttle = 10
        self.ctrlMsg.steering = 0
        self.ctrlMsg.brake = 0

        self.ctrlMsgPublisher.publish(self.ctrlMsg)
    
    def brake(self, intensity):
        self.ctrlMsg.throttle = 0
        self.ctrlMsg.steering = 0
        self.ctrlMsg.brake = intensity

        self.ctrlMsgPublisher.publish(self.ctrlMsg)

if __name__ == '__main__':
    rospy.init_node("test_node")
    
    test = Test()

    rate = rospy.Rate(60)
    while not rospy.is_shutdown():
        if test.displacement > test.maxDist:
            test.brake(1)
            print("DISTANCE GAP: {}".format(test.displacement - test.maxDist))
        else:
            test.goStraight()
        rate.sleep()
