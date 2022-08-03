#!/usr/bin/env python
# -*- coding: utf-8 -*-

# steering radian인지 60분법인지 확인하기

from yaml import scan
import rospy
import math
from lidar_team_morai.msg import ObjectInfo
from lidar_team_morai.msg import CtrlSteering
from lidar_team_morai.msg import CtrlVelocity

from visualization_msgs.msg import Marker
from std_msgs.msg import ColorRGBA
from geometry_msgs.msg import Point


class dynamicVelocity:
    def __init__(self):
        # dynamicVelocity attribute
        self.objectTotal = 0
        # object info array
        self.x = [0.0 for _ in range(30)]
        self.y = [0.0 for _ in range(30)]
        self.r = [0.0 for _ in range(30)]
        # y = a*x + b, y = c*x + d
        self.a = 999
        self.b = 999
        self.c = 999
        self.d = 999
        self.range = 1.16  # 탐색 폭 1.16 = 차량 폭 길이
        self.yPivot = 0  # 직선이 지나는 y 좌표

    def objectInfoCallBack(self, data):
        self.objectTotal = data.total
        for i in range(self.objectTotal):
            self.x[i] = data.x[i]
            self.y[i] = data.y[i]
            self.r[i] = data.r[i]

        if not self.a == 999 and self.b == 999:
            print("초기화중... CtrlSteering.msg가 안들어옴")
            self.pubVelocity()

    def SteeringCallBack(self, data):
        rad = data.steering
        print(rad)
        if -0.0001 < rad < 0.0001:
            gradient = 10000
        else:
            gradient = 1 / math.tan(rad)

        self.a, self.c = gradient, gradient
        self.b = gradient * self.range/2 + self.yPivot
        self.d = -gradient * self.range/2 + self.yPivot

        self.visualizeScanLine(rad)

        self.pubVelocity()

    def calcDistance(self, x, y):
        return math.sqrt(x*x + y*y)

    def scanRange(self, x, y, r):
        a, b, c, d = self.a, self.b, self.c, self.d
        # 점 직선 사이 거리 계산 공식 <= 반지름 or 두 직선사이 범위
        if (abs(a*x - y + b) / math.sqrt(a*a + 1)) <= r or (abs(c*x - y + d) / math.sqrt(c*c + 1)) <= r or (a*x + b <= y <= c*x + d):
            return True
        else:
            return False

    def pubVelocity(self):
        velocityMsg = CtrlVelocity()
        distance = 999
        tmpDistance = 0

        for i in range(self.objectTotal):
            if self.scanRange(self.x[i], self.y[i], self.r[i]):
                tmpDistance = self.calcDistance(self.x[i], self.y[i])
                if tmpDistance < distance:
                    distance = tmpDistance

        v = math.log(distance + math.e) * 3.5
        velocityMsg.velocity = v

        velocityPublisher.publish(velocityMsg)

    def visualizeScanLine(self, rad):
        scanLineMsg = Marker()
        scanLineMsg.header.frame_id = "/velodyne"
        scanLineMsg.ns = "scan_line"
        scanLineMsg.id = 0

        scanLineMsg.type = Marker.LINE_LIST
        scanLineMsg.action = Marker.ADD

        scanLineMsg.color = ColorRGBA(1, 0, 0, 1)
        scanLineMsg.scale.x = 0.1

        scanLineMsg.points.append(Point(self.yPivot, -self.range/2, 0))
        scanLineMsg.points.append(
            Point(math.cos(rad) * 10, -self.range/2 - math.sin(rad) * 10, 0))
        scanLineMsg.points.append(Point(self.yPivot, self.range/2, 0))
        scanLineMsg.points.append(
            Point(math.cos(rad) * 10, self.range/2 - math.sin(rad) * 10, 0))

        visualizeScanLinePub.publish(scanLineMsg)


if __name__ == '__main__':
    global velocityPublisher, visualizeScanLinePub
    dynamicVelocityObject = dynamicVelocity()

    rospy.init_node("dynamic_velocity_node")

    rospy.Subscriber("/object_info", ObjectInfo,
                     dynamicVelocityObject.objectInfoCallBack)
    rospy.Subscriber("/pure_ctrl_steering", CtrlSteering,
                     dynamicVelocityObject.SteeringCallBack)

    velocityPublisher = rospy.Publisher(
        "/dynamic_ctrl_velocity", CtrlVelocity, queue_size=1)
    visualizeScanLinePub = rospy.Publisher("/scan_line", Marker, queue_size=1)

    rospy.spin()
