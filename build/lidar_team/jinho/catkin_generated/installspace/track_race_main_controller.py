#!/usr/bin/env python2
# -*- coding: utf-8 -*-

# topic 정보 받아서 초기화 def init()
# AvoidAngleArray 필터
#     1. 중요!! 자체적으로 값이 튀었을 때 필터링 이전값 이용
#     2. priorityFilter 예측값 저장하기
# waypoint di 필터
#     1. 칼만필터를 이용하여 값이 튀었을 때를 파악하기
#     2. 모라이, 실차에 따라 토픽 구독 이름 바꾸고 변수명 몇개 바꿔야함
# object type enumerate

# import ros parts
from curses.ascii import ctrl
from cv2 import CALIB_THIN_PRISM_MODEL
import rospy
from visualization_msgs.msg import Marker
from std_msgs.msg import ColorRGBA
from geometry_msgs.msg import Point
# import STL parts
import math
# import MSG type
from jinho.msg import AvoidAngleArray
from jinho.msg import DriveValue
from jinho.msg import PurePursuit
from morai_msgs.msg import CtrlCmd


class avoidAngle:
    # constructor
    def __init__(self):
        # AvoidAngleArray attribute
        self.__totalAngles = 0
        self.__minAngles = [0.0 for _ in range(20)]
        self.__maxAngles = [0.0 for _ in range(20)]
        self.__memoryBufferSize = 10
        self.__memoryBeforePivotAngle = [
            90.0 for _ in range(self.__memoryBufferSize)]
        self.__memoryPtr = 0

    # method
    def dataProcessingCallback(self, avoidAngleArray):
        # message topic을 받아 저장
        self.setTotalAngles(avoidAngleArray.total)
        self.setMinAngles(avoidAngleArray.minAngle)
        self.setMaxAngles(avoidAngleArray.maxAngle)
        self.filterRemoveNarrowAngle()
        print(self.getTotalAngles())
        self.filterMemoryPriorityAngle()
        self.visualizePivot()
        self.visualizeWideAngle()

    def calcAverageAngle(self, minAngle, maxAngle):
        return (minAngle + maxAngle) / 2

    def getAverageAngleList(self):
        averageAngles = [0.0 for _ in range(20)]
        for i in range(self.getTotalAngles()):
            averageAngles[i] = self.calcAverageAngle(
                self.getMinAngles(i), self.getMaxAngles(i))

        return averageAngles

    def getAdjacentAngle(self, averageAngleList, pivot):
        tmpGap = 0.0
        minGap = 999
        adjacentAngle = 0.0
        for i in range(self.getTotalAngles()):
            tmpGap = abs(averageAngleList[i] - pivot)
            if tmpGap < minGap:
                adjacentAngle = averageAngleList[i]
                minGap = tmpGap

        print(adjacentAngle)
        return adjacentAngle

    def filterWideAngle(self, minAnglesList=[], maxAnglesList=[], totalInt=0):
        minAngles = minAnglesList
        maxAngles = maxAnglesList
        total = totalInt
        tmpCalcAngleRange = 0.0
        maxAngleRange = 0.0
        resultAngleList = [0.0, 0.0]
        if total == 0:
            minAngles = self.getMinAngles()
            maxAngles = self.getMaxAngles()
            total = self.getTotalAngles()

        for i in range(total):
            tmpCalcAngleRange = maxAngles[i] - minAngles[i]
            if tmpCalcAngleRange > maxAngleRange:
                maxAngleRange = tmpCalcAngleRange
                resultAngleList[0] = minAngles[i]
                resultAngleList[1] = maxAngles[i]
        return resultAngleList

    def filterRemoveNarrowAngle(self, angleRange=0):
        minAngles = []
        maxAngles = []
        tmpAngleRange = 0.0
        discount = 0
        for i in range(self.getTotalAngles()):
            tmpAngleRange = self.getMaxAngles(i) - self.getMinAngles(i)
            if tmpAngleRange < angleRange:
                discount += 1
                continue
            minAngles.append(self.getMinAngles(i))
            maxAngles.append(self.getMaxAngles(i))

        for i in range(self.getTotalAngles() - discount):
            self.setMinAngles(idx=i, value=minAngles[i])
            self.setMaxAngles(idx=i, value=maxAngles[i])
        self.setTotalAngles(self.getTotalAngles() - discount)

    def filterMemoryPriorityAngle(self):
        # 이전 값 불러오는 변수 생성
        beforePivot = 0.0
        presentPivot = 0.0
        # 이전 인덱스에 있는 pivot값 가져오기
        if self.__memoryPtr == 0:
            beforePivot = self.__memoryBeforePivotAngle[self.__memoryBufferSize - 1]
        else:
            beforePivot = self.__memoryBeforePivotAngle[self.__memoryPtr - 1]

        # angles 각마다 평균각 계산
        averageAngles = self.getAverageAngleList()

        # pivot 기준 가까운 범위를 발행
        presentPivot = self.getAdjacentAngle(
            averageAngleList=averageAngles, pivot=beforePivot)

        # 최신 pivot을 저장하기 전 예측값으로 변환 후 저장
        for i in range(self.__memoryPtr, -1, -1):
            pass
        for i in range(9, self.__memoryPtr, -1):
            pass
        self.__memoryPtr = (self.__memoryPtr + 1) % self.__memoryBufferSize
        self.__memoryBeforePivotAngle[self.__memoryPtr] = presentPivot

    def filterDiPriority(self):
        pass

    def visualizeWideAngle(self):
        wideAngle = self.filterWideAngle()
        wideAngleMarker = Marker()
        wideAngleMarker.header.frame_id = "/velodyne"
        wideAngleMarker.ns = "wideAngleMarker"
        wideAngleMarker.id = 1
        wideAngleMarker.type = wideAngleMarker.LINE_LIST
        wideAngleMarker.action = wideAngleMarker.ADD
        wideAngleMarker.color = ColorRGBA(0, 1, 1, 0.5)
        wideAngleMarker.scale.x = 0.1
        wideAngleMarker.points.append(Point(0, 0, 0))
        wideAngleMarker.points.append(
            Point(10 * math.sin(wideAngle[0] * math.pi / 180),
                  10 * math.cos(wideAngle[0] * math.pi / 180),
                  0))
        wideAngleMarker.points.append(Point(0, 0, 0))
        wideAngleMarker.points.append(
            Point(10 * math.sin(wideAngle[1] * math.pi / 180),
                  10 * math.cos(wideAngle[1] * math.pi / 180),
                  0))
        pivotLinePub.publish(wideAngleMarker)

    def visualizePivot(self):
        pivotLineMarker = Marker()
        pivotLineMarker.header.frame_id = "/velodyne"
        pivotLineMarker.ns = "pivotLineMarker"
        pivotLineMarker.id = 1
        pivotLineMarker.type = Marker.LINE_LIST
        pivotLineMarker.action = Marker.ADD
        pivotLineMarker.color = ColorRGBA(0, 1, 0, 1)
        pivotLineMarker.scale.x = 0.05
        pivotLineMarker.points.append(Point(0, 0, 0))
        pivotLineMarker.points.append(Point(10 * math.sin(self.__memoryBeforePivotAngle[self.__memoryPtr] * math.pi / 180),
                                            10 * math.cos(
                                                self.__memoryBeforePivotAngle[self.__memoryPtr] * math.pi / 180),
                                            0))
        pivotLinePub.publish(pivotLineMarker)

    # getter

    def getTotalAngles(self):
        return self.__totalAngles

    def getMinAngles(self, idx=999):
        if idx == 999:
            return self.__minAngles
        elif 0 <= idx < self.getTotalAngles():
            return self.__minAngles[idx]

    def getMaxAngles(self, idx=999):
        if idx == 999:
            return self.__maxAngles
        elif 0 <= idx < self.getTotalAngles():
            return self.__maxAngles[idx]

    def getMemoryPivotAngle(self):
        return self.__memoryBeforePivotAngle[self.__memoryPtr]
    # setter

    def setTotalAngles(self, totalAngles):
        self.__totalAngles = totalAngles

    def setMinAngles(self, minAngles=[], idx=999, value=0.0):
        if idx == 999:
            self.__minAngles = list(minAngles)
        else:
            self.__minAngles[idx] = value

    def setMaxAngles(self, maxAngles=[], idx=999, value=0.0):
        if idx == 999:
            self.__maxAngles = list(maxAngles)
        else:
            self.__maxAngles[idx] = value


class purePursuit:
    # constructor
    def __init__(self):
        # purePursuit attribute
        self.__steering = 0.0
        self.__deltaSteering = 0.0

    # method
    def dataProcessingCallback(self, pursuit):
        # message topic을 받아 저장
        self.setSteering(pursuit.steering)
        # print(abs(self.__deltaSteering * 1000) > 50)
        controller.catchSignal()

    # getter

    def getSteering(self):
        return self.__steering

    def getDeltaSteering(self):
        return self.__deltaSteering

    # setter
    def setSteering(self, steering):
        if not steering == self.__steering:
            self.setDeltaSteering(steering)
            self.__steering = steering

    def setDeltaSteering(self, presentSteering):
        self.__deltaSteering = presentSteering - self.__steering


class control:
    def __init__(self):
        self.__correctionSteering = 0.0
        self.__avoidAngleSignal = 0
        self.__purePursuitSignal = 0
        self.__avoidAngleObject = 0
        self.__purePursuitObject = 1

    def catchSignal(self, flag=-1):
        ctrl_msg = CtrlCmd()
        self.__correctionSteering = self.catchNoiseCompareSNP(10)
        ctrl_msg.longlCmdType = 2
        ctrl_msg.steering = self.__correctionSteering
        ctrl_msg.velocity = 15
        ctrlPub.publish(ctrl_msg)

    def catchNoiseDeltaSteering(self):
        pass

    def catchNoiseCompareSNP(self, alpha):
        # steering과 pivot angle 비교
        pivotAngle = avoidAngleObject.getMemoryPivotAngle()
        steering = purePursuitObject.getSteering() * 180 / math.pi + 90
        if pivotAngle - alpha < steering < pivotAngle + alpha:
            return steering
        else:
            return pivotAngle


if __name__ == '__main__':
    rospy.init_node('track_race_main_controller_node')
    global avoidAngleObject, purePursuitObject, controller
    global pivotLinePub, ctrlPub
    ctrlPub = rospy.Publisher("ctrl_cmd", CtrlCmd, queue_size=1)
    pivotLinePub = rospy.Publisher("pivot_line", Marker, queue_size=1)
    avoidAngleObject = avoidAngle()
    purePursuitObject = purePursuit()
    controller = control()
    rospy.Subscriber("avoid_angles", AvoidAngleArray,
                     avoidAngleObject.dataProcessingCallback)
    rospy.Subscriber("pure_pursuit", PurePursuit,
                     purePursuitObject.dataProcessingCallback)
    # rospy.Subscriber("ctrl_cmd", CtrlCmd,
    #                  purePursuitObject.dataProcessingCallback)
    rospy.spin()
