#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pyproj import Proj, transform
import rospy
from std_msgs.msg import Float64
from geometry_msgs.msg import Point
from sensor_msgs.msg import NavSatFix
from math import sqrt

prev_sec = 0
prev_x = 0
prev_y = 0

def wgs84_to_utmk(data):
    global prev_sec, prev_x, prev_y
    latitude = data.latitude
    longitude = data.longitude
    utmk_coordinate = Point() 

    # UTM-K
    proj_UTMK = Proj(init='epsg:5179')

    # WGS84
    proj_WGS84 = Proj(init='epsg:4326')

    x, y = transform(proj_WGS84, proj_UTMK, longitude, latitude) 
    utmk_coordinate.x = x
    utmk_coordinate.y = y
    utmk_coordinate.z = 0


    nsecs = data.header.stamp.nsecs
    nsecs = float(nsecs)
    sec = data.header.stamp.secs + nsecs/1000000000

    if sec == 0:
        return

    deltaSec = sec - prev_sec

    if prev_sec != 0 and deltaSec != 0:
        velocity = ( sqrt( pow( (utmk_coordinate.x - prev_x), 2 ) + pow( (utmk_coordinate.y - prev_y), 2) ) / deltaSec ) * 3600 / 1000

        print(velocity)
        velPub.publish(velocity)

    prev_x = utmk_coordinate.x
    prev_y = utmk_coordinate.y
    prev_sec = sec
    
if __name__ == "__main__":
    rospy.init_node("gps_velocity")
    rospy.Subscriber("/gps_front/fix", NavSatFix, wgs84_to_utmk)
    velPub = rospy.Publisher("gps_velocity", Float64, queue_size = 1)

    rate = rospy.Rate(60)

    while not rospy.is_shutdown():
        rate.sleep()