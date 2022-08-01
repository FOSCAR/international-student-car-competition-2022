// 해결
// 굳이 mainCallback에서 pub을 해야하는가? (roi 변경하기)
// 객체 부피 말고 xy평면에 넓이로 바꾸는것
// 장애물 차량거리를 계산해야 하는가?

// TODO 
// cluster id 상수
// 범위로 나누어서 가능성 생각
// cfg 설정

// include ROS parts
#include <ros/ros.h>
#include <dynamic_reconfigure/server.h>
#include "jinho/jinhoConfig.h"
#include <sensor_msgs/PointCloud2.h>
// include PCL parts
#include <pcl_conversions/pcl_conversions.h>
#include <pcl/PCLPointCloud2.h>
#include <pcl/point_types.h>
#include <pcl/filters/passthrough.h>
#include <pcl/common/common.h>
#include <pcl/search/kdtree.h>
#include "../include/jinho/dbscan.h"
// include visualization parts
#include <visualization_msgs/Marker.h>
#include <visualization_msgs/MarkerArray.h>
// include STL parts
#include <vector>
// include jinho handmade parts
#include "../include/jinho/square_scanner.h"
#include "../include/jinho/object_info.h"
// include jinho handmade msg parts
#include <jinho/AvoidAngleArray.h>

// pcl point type
typedef pcl::PointXYZ PointT;
// cluster point type
typedef pcl::PointXYZI clusterPointT;

// ROI parameter
double z_min, z_max, x_min, x_max, y_min, y_max;
// DBScan parameter
int minPoints;
double epsilon, minClusterSize, maxClusterSize;
// object radius weight parameter
double objectRadiusWeight; // 일반적으로 차량 폭 절반
double pivotX, pivotY;

// publisher
ros::Publisher pubROI;
ros::Publisher pubCluster;
ros::Publisher pubCarShape;
ros::Publisher pubSensingLine;
ros::Publisher pubObjectShapeArray;
ros::Publisher pubSensingCircleArray;
ros::Publisher pubAvoidAngleArray;

// manage objects
objectArray objects;
squareScanner scanner(-10, 0, 10, 5, 0, 0);


void cfgCallback(jinho::jinhoConfig &config, int32_t level) {
    x_min = config.x_min;
    x_max = config.x_max;
    y_min = config.y_min;
    y_max = config.y_max;
    z_min = config.z_min;
    z_max = config.z_max;

    minPoints = config.minPoints;
    epsilon = config.epsilon;
    minClusterSize = config.minClusterSize;
    maxClusterSize = config.maxClusterSize;

    objectRadiusWeight = config.objectRadiusWeight;
    scanner.setPivotX(config.pivotX);
    scanner.setPivotY(config.pivotY);

    scanner.setMaxX(x_max);
    scanner.setMaxY(y_max);
    scanner.setMinX(x_min);
    scanner.setMinY(y_min);
    std::cout << "scanner maxX: " << scanner.getMaxX() << "\n";
    std::cout << "scanner maxY: " << scanner.getMaxY() << "\n";
    std::cout << "scanner minX: " << scanner.getMinX() << "\n";
    std::cout << "scanner minY: " << scanner.getMinY() << "\n";
}

pcl::PointCloud<PointT>::Ptr ROI (const sensor_msgs::PointCloud2ConstPtr& input) {
    // ... do data processing
    pcl::PointCloud<PointT>::Ptr cloud(new pcl::PointCloud<PointT>);

    pcl::fromROSMsg(*input, *cloud); // sensor_msgs -> PointCloud 형변환

    pcl::PointCloud<PointT>::Ptr cloud_filtered(new pcl::PointCloud<PointT>);
    // pcl::PointCloud<PointT>::Ptr *retPtr = &cloud_filtered;
    std::cout << "Loaded : " << cloud->width * cloud->height << "\n";

    // 오브젝트 생성 
    // Z축 ROI
    pcl::PassThrough<PointT> filter;
    filter.setInputCloud(cloud);                //입력 
    filter.setFilterFieldName("z");             //적용할 좌표 축 (eg. Z축)
    filter.setFilterLimits(z_min, z_max);          //적용할 값 (최소, 최대 값)
    //filter.setFilterLimitsNegative (true);     //적용할 값 외 
    filter.filter(*cloud_filtered);             //필터 적용 

    // X축 ROI
    // pcl::PassThrough<PointT> filter;
    filter.setInputCloud(cloud_filtered);                //입력 
    filter.setFilterFieldName("x");             //적용할 좌표 축 (eg. X축)
    filter.setFilterLimits(x_min, x_max);          //적용할 값 (최소, 최대 값)
    //filter.setFilterLimitsNegative (true);     //적용할 값 외 
    filter.filter(*cloud_filtered);             //필터 적용 

    // Y축 ROI
    // pcl::PassThrough<PointT> filter;
    filter.setInputCloud(cloud_filtered);                //입력 
    filter.setFilterFieldName("y");             //적용할 좌표 축 (eg. Y축)
    filter.setFilterLimits(y_min, y_max);          //적용할 값 (최소, 최대 값)
    //filter.setFilterLimitsNegative (true);     //적용할 값 외 
    filter.filter(*cloud_filtered);             //필터 적용 

    // 포인트수 출력
    // std::cout << "ROI Filtered :" << cloud_filtered->width * cloud_filtered->height  << std::endl; 

    sensor_msgs::PointCloud2 roi_raw;
    pcl::toROSMsg(*cloud_filtered, roi_raw);
    
    pubROI.publish(roi_raw);

    return cloud_filtered;
}

void cluster(pcl::PointCloud<PointT>::Ptr input) {
    //KD-Tree
    pcl::search::KdTree<PointT>::Ptr tree(new pcl::search::KdTree<PointT>);
    pcl::PointCloud<clusterPointT>::Ptr clusterPtr(new pcl::PointCloud<clusterPointT>);
    tree->setInputCloud(input);

    //Segmentation
    std::vector<pcl::PointIndices> cluster_indices;

    //DBSCAN with Kdtree for accelerating
    DBSCANKdtreeCluster<PointT> dc;
    dc.setCorePointMinPts(minPoints);   //Set minimum number of neighbor points
    dc.setClusterTolerance(epsilon); //Set Epsilon 
    dc.setMinClusterSize(minClusterSize);
    dc.setMaxClusterSize(maxClusterSize);
    dc.setSearchMethod(tree);
    dc.setInputCloud(input);
    dc.extract(cluster_indices);

    pcl::PointCloud<clusterPointT> totalcloud_clustered;
    int cluster_id = 0;
    objects.total = 0;
    scanner.initAngles();

    //각 Cluster 접근
    for (std::vector<pcl::PointIndices>::const_iterator it = cluster_indices.begin(); it != cluster_indices.end(); it++, cluster_id++) {
        pcl::PointCloud<clusterPointT> eachcloud_clustered;
        float cluster_counts = cluster_indices.size();

        //각 Cluster내 각 Point 접근
        for(std::vector<int>::const_iterator pit = it->indices.begin(); pit != it->indices.end(); ++pit) {

            clusterPointT tmp;
            tmp.x = input->points[*pit].x; 
            tmp.y = input->points[*pit].y;
            tmp.z = input->points[*pit].z;
            tmp.intensity = cluster_id%20; // 상수 : 예상 가능한 cluster 총 개수
            eachcloud_clustered.push_back(tmp);
            totalcloud_clustered.push_back(tmp);
        }

        //minPoint와 maxPoint 받아오기
        clusterPointT minPoint, maxPoint;
        pcl::getMinMax3D(eachcloud_clustered, minPoint, maxPoint);

        objects.objects[objects.total].maxX = maxPoint.x;
        objects.objects[objects.total].maxY = maxPoint.y;
        objects.objects[objects.total].maxZ = maxPoint.z;
        objects.objects[objects.total].minX = minPoint.x;
        objects.objects[objects.total].minY = minPoint.y;
        objects.objects[objects.total].minZ = minPoint.z;
        objects.objects[objects.total].centerX = (minPoint.x + maxPoint.x)/2; //직육면체 중심 x 좌표
        objects.objects[objects.total].centerY = (minPoint.y + maxPoint.y)/2; //직육면체 중심 y 좌표
        objects.objects[objects.total].centerZ = (minPoint.z + maxPoint.z)/2; //직육면체 중심 z 좌표
        objects.objects[objects.total].radiusXY = sqrt(pow((maxPoint.x - minPoint.x), 2) + pow((maxPoint.y - minPoint.y), 2)) + objectRadiusWeight;
        objects.objects[objects.total].radiusXYZ = sqrt(pow(objects.objects[objects.total].radiusXY, 2) + pow((maxPoint.z - minPoint.z), 2)) + objectRadiusWeight;

        detectAngleType detected = scanner.calcObjectPosition(
            objects.objects[objects.total].centerX,
            objects.objects[objects.total].centerY,
            objects.objects[objects.total].radiusXY);
        scanner.pushDetectAngle(detected);
 
        objects.total++;
    }

    scanner.calcAvailableAngle(objects.total);
    scanner.print();
    

    sensor_msgs::PointCloud2 cluster_point;
    pcl::toROSMsg(totalcloud_clustered, cluster_point);
    cluster_point.header.frame_id = "/velodyne";
    pubCluster.publish(cluster_point);    
}

void visualizeCar() {
    uint32_t shape = visualization_msgs::Marker::CUBE; // Set our initial shape type to be a cube
    visualization_msgs::Marker carShape;

    // Set the frame ID and timestamp.  See the TF tutorials for information on these.
    carShape.header.frame_id = "/velodyne"; 
    carShape.header.stamp = ros::Time::now();

    // Set the namespace and id for this marker.  This serves to create a unique ID
    // Any marker sent with the same namespace and id will overwrite the old one
    carShape.ns = "car_shape";
    carShape.id = 0;

    // Set the marker type.  Initially this is CUBE, and cycles between that and SPHERE, ARROW, and CYLINDER
    carShape.type = shape;

    // Set the marker action.  Options are ADD and DELETE
    carShape.action = visualization_msgs::Marker::ADD;

    // Set the pose of the marker.  This is a full 6DOF pose relative to the frame/time specified in the header
    carShape.pose.position.x = -0.4;
    carShape.pose.position.y = 0;
    carShape.pose.position.z = 0.1;
    carShape.pose.orientation.x = 0.0;
    carShape.pose.orientation.y = 0.0;
    carShape.pose.orientation.z = 0.0;
    carShape.pose.orientation.w = 1.0;

    // Set the scale of the marker -- 1x1x1 here means 1m on a side
    carShape.scale.x = 1.6;
    carShape.scale.y = 1.16;
    carShape.scale.z = 0.55;
 
    // Set the color -- be sure to set alpha to something non-zero!
    carShape.color.r = 0.0f;
    carShape.color.g = 1.0f;
    carShape.color.b = 0.0f;
    carShape.color.a = 1.0;

    carShape.lifetime = ros::Duration();

    // Publish the marker
    pubCarShape.publish(carShape);
}

void visualizeObject() {
    visualization_msgs::MarkerArray objectShapeArray;
    visualization_msgs::Marker objectShape;
    uint32_t shape = visualization_msgs::Marker::CYLINDER; // Set our initial shape type to be a cube
    // Set the frame ID and timestamp.  See the TF tutorials for information on these.
    objectShape.header.frame_id = "/velodyne"; 
    objectShape.ns = "object_shape";
    // Set the marker type.  Initially this is CUBE, and cycles between that and SPHERE, ARROW, and CYLINDER
    objectShape.type = shape;
    // Set the marker action.  Options are ADD and DELETE
    objectShape.action = visualization_msgs::Marker::ADD;
    for (int i = 0; i < objects.total; i++) {
        // Set the namespace and id for this marker.  This serves to create a unique ID
        // Any marker sent with the same namespace and id will overwrite the old one
        objectShape.header.stamp = ros::Time::now();
        objectShape.id = 100+i; // 

        // Set the pose of the marker.  This is a full 6DOF pose relative to the frame/time specified in the header
        objectShape.pose.position.x = objects.objects[i].centerX;
        objectShape.pose.position.y = objects.objects[i].centerY;
        objectShape.pose.position.z = objects.objects[i].centerZ;

        // Set the scale of the marker -- 1x1x1 here means 1m on a side
        objectShape.scale.x = objects.objects[i].radiusXY + objectRadiusWeight;
        objectShape.scale.y = objects.objects[i].radiusXY + objectRadiusWeight;
        // objectShape.scale.x = 0.5;
        // objectShape.scale.y = 0.5;
        objectShape.scale.z = objects.objects[i].maxZ - objects.objects[i].minZ;
    
        // Set the color -- be sure to set alpha to something non-zero!
        objectShape.color.r = 1.0;
        objectShape.color.g = 1.0;
        objectShape.color.b = 1.0;
        objectShape.color.a = 0.8;

        objectShape.lifetime = ros::Duration(0.1);
        objectShapeArray.markers.emplace_back(objectShape);
    }

    // Publish the marker
    pubObjectShapeArray.publish(objectShapeArray);
}

void visualizeSensingRange() {
    uint32_t shape = visualization_msgs::Marker::LINE_LIST; // Set our initial shape type to be a cube
    visualization_msgs::Marker sensingLine;

    // Set the frame ID and timestamp.  See the TF tutorials for information on these.
    sensingLine.header.frame_id = "/velodyne"; 
    sensingLine.header.stamp = ros::Time::now();

    // Set the namespace and id for this marker.  This serves to create a unique ID
    // Any marker sent with the same namespace and id will overwrite the old one
    sensingLine.ns = "sensing_lines";
    sensingLine.id = 2;

    // Set the marker type.  Initially this is CUBE, and cycles between that and SPHERE, ARROW, and CYLINDER
    sensingLine.type = shape;

    // Set the marker action.  Options are ADD and DELETE
    sensingLine.action = visualization_msgs::Marker::ADD;

    // Set the pose of the marker.  This is a full 6DOF pose relative to the frame/time specified in the header
    sensingLine.pose.orientation.w = 1.0;

    // Set the scale of the marker
    sensingLine.scale.x = 0.1;
 
    // Set the color -- be sure to set alpha to something non-zero!
    sensingLine.color.r = 0.5f;
    sensingLine.color.g = 0.0f;
    sensingLine.color.b = 0.0f;
    sensingLine.color.a = 1.0;

    geometry_msgs::Point p;

    double minAngle, maxAngle;

    for (int i = 0; i < scanner.availableAngles.total; i++) {
        minAngle = scanner.availableAngles.minAngle[i] * M_PI / 180.0;
        maxAngle = scanner.availableAngles.maxAngle[i] * M_PI / 180.0;
        p.x = 0;
        p.y = 0;
        p.z = 0;
        sensingLine.points.push_back(p);
        p.x = sin(minAngle) * 10;
        p.y = cos(minAngle) * 10;
        p.z = 0;
        sensingLine.points.push_back(p);
        p.x = 0;
        p.y = 0;
        p.z = 0;
        sensingLine.points.push_back(p);
        p.x = sin(maxAngle) * 10;
        p.y = cos(maxAngle) * 10;
        p.z = 0;
        sensingLine.points.push_back(p);
    }

    sensingLine.lifetime = ros::Duration(0.1);

    // Publish the marker
    pubSensingLine.publish(sensingLine);

    return;
}

void visualizeSensingCircle() {
    uint32_t shape = visualization_msgs::Marker::CYLINDER; // Set our initial shape type to be a cube
    visualization_msgs::Marker sensingCircle;
    visualization_msgs::MarkerArray sensingCircleArray;

    // Set the frame ID and timestamp.  See the TF tutorials for information on these.
    sensingCircle.header.frame_id = "/velodyne"; 
    sensingCircle.header.stamp = ros::Time::now();

    // Set the marker type.  Initially this is CUBE, and cycles between that and SPHERE, ARROW, and CYLINDER
    sensingCircle.type = shape;

    // Set the marker action.  Options are ADD and DELETE
    sensingCircle.action = visualization_msgs::Marker::ADD;

    // Set the namespace and id for this marker.  This serves to create a unique ID
    // Any marker sent with the same namespace and id will overwrite the old one
    sensingCircle.ns = "sensing_circle";
    double deltaRadius = 0.1;
    double Radius = 0.1;
    for (int i = 0; i < 100; i++) {
        sensingCircle.id = 200 + i;

        // Set the pose of the marker.  This is a full 6DOF pose relative to the frame/time specified in the header
        sensingCircle.pose.position.x = 0;
        sensingCircle.pose.position.y = 0;
        sensingCircle.pose.position.z = -0.6;

        // Set the scale of the marker -- 1x1x1 here means 1m on a side
        sensingCircle.scale.x = Radius + deltaRadius;
        sensingCircle.scale.y = Radius + deltaRadius;
        sensingCircle.scale.z = 0.1;
    
        // Set the color -- be sure to set alpha to something non-zero!
        sensingCircle.color.r = 0.0f;
        sensingCircle.color.g = 1.0f;
        sensingCircle.color.b = 1.0f;
        sensingCircle.color.a = 0.01;

        sensingCircle.lifetime = ros::Duration(0.1);

        Radius += deltaRadius;
    }

    // Publish the marker
    pubSensingCircleArray.publish(sensingCircle);

    return;
}

void publishAvoidAngleArrayMSG() {
    jinho::AvoidAngleArray msg;
    msg.total = scanner.availableAngles.total;
    if (msg.total > 20) {
        ROS_INFO("TOTAL ANGLE OVERFLOW MAX 20");
        ROS_INFO("SOLVE: MODIFY AvoidAngleArray.msg arraysize");
        for (int i = 0; i < 20; i++) {
            msg.minAngle[i] = scanner.availableAngles.minAngle[i];
            msg.maxAngle[i] = scanner.availableAngles.maxAngle[i];
        }
    } else {
        for (int i = 0; i < scanner.availableAngles.total; i++) {
            msg.minAngle[i] = scanner.availableAngles.minAngle[i];
            msg.maxAngle[i] = scanner.availableAngles.maxAngle[i];
        }
    }

    pubAvoidAngleArray.publish(msg);
}

void sensingBox() {

}

void sensingCircularSector() {

}

void mainCallback(const sensor_msgs::PointCloud2ConstPtr& input) {
    pcl::PointCloud<PointT>::Ptr roiPoint;
    visualizeCar();
    visualizeObject();

    roiPoint = ROI(input);
    cluster(roiPoint);
    publishAvoidAngleArrayMSG();
    
    visualizeSensingRange();
}

int main (int argc, char** argv) {
    // Initialize ROS
    ros::init (argc, argv, "jinho_node");
    ros::NodeHandle nh;
    
    dynamic_reconfigure::Server<jinho::jinhoConfig> server;
    dynamic_reconfigure::Server<jinho::jinhoConfig>::CallbackType f;

    f = boost::bind(&cfgCallback, _1, _2);
    server.setCallback(f);
    // Create a ROS subscriber for the input point cloud
    ros::Subscriber sub = nh.subscribe ("velodyne_points", 1, mainCallback);

    // Create a ROS publisher for the output point cloud
    pubROI = nh.advertise<sensor_msgs::PointCloud2> ("roi_raw", 1);
    pubCluster = nh.advertise<sensor_msgs::PointCloud2>("cluster", 1);
    pubCarShape = nh.advertise<visualization_msgs::Marker>("visualization_marker", 1);
    pubSensingLine = nh.advertise<visualization_msgs::Marker>("visualization_range", 1);
    pubObjectShapeArray = nh.advertise<visualization_msgs::MarkerArray>("visualization_object", 1);
    pubSensingCircleArray = nh.advertise<visualization_msgs::MarkerArray>("visualization_sensing_circle", 1);
    pubAvoidAngleArray = nh.advertise<jinho::AvoidAngleArray>("avoid_angles", 1);

    // Spin
    ros::spin ();
}