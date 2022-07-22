#!/usr/bin/env python
# -*- coding: utf-8 -*-

from threading import local
import numpy as np
from std_msgs.msg import Float64,Int16,Float32MultiArray
import math
import rospy
import rospkg
import tf
from visualization_msgs.msg import Marker
from visualization_msgs.msg import MarkerArray
from lidar_team_morai.msg import Waypoint


import cv2, time
import copy
from darknet_ros_msgs.msg import BoundingBox, BoundingBoxes
from sensor_msgs.msg import Image
from vision_distance.msg import Colorcone_lidar, ColorconeArray_lidar
from geometry_msgs.msg import Point
from cv_bridge import CvBridge

linspace_num = 200

yellow_array = []
blue_array = []

class drawing_path():
    def __init__(self):
        global linspace_num, yellow_array, blue_array

        rospy.init_node('linspace')
        pub1 = rospy.Publisher('waypoint_linsapce', MarkerArray, queue_size = 1)
        pub2 = rospy.Publisher('local_path', Waypoint, queue_size = 1)
        pub3 = rospy.Publisher('yellow_cone', MarkerArray, queue_size = 1)
        pub4 = rospy.Publisher('blue_cone', MarkerArray, queue_size = 1)
        rospy.Subscriber('/waypoint_position', Waypoint, self.callback)
        bbox_sub = rospy.Subscriber("/darknet_ros/bounding_boxes/", BoundingBoxes, self.bounding_callback)

        self.x_array = []
        self.y_array = []

        array = [[] for _ in range(linspace_num)]

        box_class = None
        box_xmin = None
        box_xmax = None
        box_ymin = None
        box_ymax = None

        rate = rospy.Rate(30)

        while not rospy.is_shutdown():
            
            local_path = Waypoint()

            yellow_cone_marker_arr = MarkerArray()
            blue_cone_marker_arr = MarkerArray()

            if len(self.x_array) > 1 and len(self.y_array) > 1:

                x = self.x_array
                y = self.y_array
                cnt = self.cnt - 1

                try:
                    z = np.polyfit(x, y, 2)
                except:
                    pass
                p = np.poly1d(z)

            
                # evaluate on new data points
                x_new = np.linspace(min(x), max(x), 200)
                y_new = p(x_new)

                for i in range(linspace_num):
                    array[i] = [x_new[i], y_new[i]]
                
                # print(array)

                waypoint_marker_arr = MarkerArray()

                for i in range(linspace_num):
                    marker = Marker()
                    marker.header.frame_id = "/velodyne"
                    marker.id = i
                    marker.type = marker.SPHERE
                    marker.action = marker.ADD
                    marker.scale.x = 0.05
                    marker.scale.y = 0.05
                    marker.scale.z = 0.05	                  
                    marker.color.a = 1.0
                    marker.color.r = 0.0
                    marker.color.g = 1.0
                    marker.color.b = 0.0
                    marker.pose.orientation.w = 1.0
                    marker.pose.position.x = array[i][0]
                    marker.pose.position.y = array[i][1]
                    marker.pose.position.z = 0.2

                    marker.lifetime = rospy.Duration(0.1)

                    waypoint_marker_arr.markers.append(marker)
                
                    local_path.x_arr[i] = array[i][0]
                    local_path.y_arr[i] = array[i][1]

                pub1.publish(waypoint_marker_arr)
                pub2.publish(local_path)

            if len(yellow_array) != 0:
                for i in range(len(yellow_array)):
                    marker = Marker()
                    marker.header.frame_id = "/velodyne"
                    marker.id = i*123
                    marker.type = marker.SPHERE
                    marker.action = marker.ADD

                    marker.scale.x = 1.0
                    marker.scale.y = 1.0
                    marker.scale.z = 1.0	

                    marker.color.a = 1.0
                    marker.color.r = 1.0
                    marker.color.g = 1.0
                    marker.color.b = 0.0
                    marker.pose.orientation.w = 1.0
                    marker.pose.position.x = yellow_array[i][1] / 15 * -1
                    marker.pose.position.y = yellow_array[i][0] / 15 * -1
                    marker.pose.position.z = 0.2

                    marker.lifetime = rospy.Duration(0.1)

                    yellow_cone_marker_arr.markers.append(marker)

                pub3.publish(yellow_cone_marker_arr)

            if len(blue_array) != 0:  
                for i in range(len(blue_array)):
                    marker = Marker()
                    marker.header.frame_id = "/velodyne"
                    marker.id = i*456
                    marker.type = marker.SPHERE
                    marker.action = marker.ADD

                    marker.scale.x = 1.0
                    marker.scale.y = 1.0
                    marker.scale.z = 1.0	

                    marker.color.a = 1.0
                    marker.color.r = 0.0
                    marker.color.g = 0.0
                    marker.color.b = 1.0
                    marker.pose.orientation.w = 1.0
                    marker.pose.position.x = blue_array[i][1] / 15 * -1
                    marker.pose.position.y = blue_array[i][0] / 15 * -1
                    marker.pose.position.z = 0.2

                    marker.lifetime = rospy.Duration(0.1)

                    blue_cone_marker_arr.markers.append(marker)

                pub4.publish(blue_cone_marker_arr)

            yellow_array = []
            blue_array = []

            rate.sleep()


    def callback(self, msg):
        self.x_array = list(msg.x_arr)[0:msg.cnt]
        self.y_array = list(msg.y_arr)[0:msg.cnt]
        self.cnt = msg.cnt

        # self.x_array.insert(0, 0)
        # self.y_array.insert(0, 0)

        self.x_array.insert(0, -0.92)
        self.y_array.insert(0, 0)
    
    def bounding_callback(self, msg):
        global yellow_array, blue_array

        for i in range(len(msg.bounding_boxes)):
            bbox = msg.bounding_boxes
            color = bbox[i].Class
            x_center = (bbox[i].xmin + bbox[i].xmax) / 2
            y_center = (bbox[i].ymin + bbox[i].ymax) / 2

            if color == "yellow cone":
                yellow_array.append((x_center, y_center))
            else:
                blue_array.append((x_center, y_center))


if __name__ == '__main__':
    try:
        drawing = drawing_path()
    except rospy.ROSInterruptException:
        pass