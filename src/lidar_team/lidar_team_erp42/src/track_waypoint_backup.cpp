#include "header.h"
#include "dbscan.h"

using namespace std;

#define TANGENT 1.0          // tan45도

int minPoints; //10          //Core Point 기준 필요 인접점 최소 개수
double epsilon; //0.3        //Core Point 기준 주변 탐색 반경 

int minClusterSize; //10     //Cluster 최소 사이즈
int maxClusterSize; //10000  //Cluster 최대 사이즈

double xMinROI, xMaxROI, yMinROI, yMaxROI, zMinROI, zMaxROI; // ROI(PassThrough) 범위 지정 변수

double xMinBoundingBox, xMaxBoundingBox, yMinBoundingBox, yMaxBoundingBox, zMinBoundingBox, zMaxBoundingBox; // BoundingBox 크기 범위 지정 변수 

bool cmp(const vector<float>& v1, const vector<float>& v2) {
    return v1[3] < v2[3];
}

float getDistanceC2C(const vector<float>& v1, const vector<float>& v2) {
  float c2c_distance;
  c2c_distance = sqrt( pow(v1[0] - v2[0], 2) + pow(v1[1] - v2[1], 2) );
  return c2c_distance;
}

float getTangentC2C(const vector<float>& v1, const vector<float>& v2) {
  float c2c_tangent;
  c2c_tangent = abs( (v1[1] - v2[1]) / (v1[0] - v2[0]) );
  return c2c_tangent;
}

void dynamicParamCallback(lidar_team_erp42::hyper_parameterConfig &config, int32_t level) {
  xMinROI = config.xMinROI;
  xMaxROI = config.xMaxROI;
  yMinROI = config.yMinROI;
  yMaxROI = config.yMaxROI;
  zMinROI = config.zMinROI;
  zMaxROI = config.zMaxROI;

  minPoints = config.minPoints;
  epsilon = config.epsilon;
  minClusterSize = config.minClusterSize;
  maxClusterSize = config.maxClusterSize;

  xMinBoundingBox = config.xMinBoundingBox;
  xMaxBoundingBox = config.xMaxBoundingBox;
  yMinBoundingBox = config.yMinBoundingBox;
  yMaxBoundingBox = config.yMaxBoundingBox;
  zMinBoundingBox = config.zMinBoundingBox;
  zMaxBoundingBox = config.zMaxBoundingBox;
}

typedef pcl::PointXYZ PointT;

vector<float> obstacle;
vector< vector<float> > obstacle_vec;
vector< vector<float> > obstacle_buffer;
vector< vector<float> > obstacle_left;
vector< vector<float> > obstacle_right;
vector< vector<float> > waypoint_arr;

ros::Publisher clusterPub; //Cluster Publishser
ros::Publisher boundingBoxMarkerPub; //Bounnding Box Visualization Publisher
ros::Publisher waypointMarkerPub; //Waypoint Visualization Publisher
ros::Publisher boundingBoxPosePub; //Bounding Box Position Publisher
ros::Publisher waypointPosePub; //Waypoint Position Publisher
ros::Publisher leftConesMarkerPub; //left Box Publisher
ros::Publisher rightConesMarkerPub; //right Box Publisher
ros::Publisher cropboxPub; //Cluster PublishserCOMPONENTS


void cloud_cb(const sensor_msgs::PointCloud2ConstPtr& inputcloud) {
  //ROS message 변환
  //PointXYZI가 아닌 PointXYZ로 선언하는 이유 -> 각각의 Cluster를 다른 색으로 표현해주기 위해서. Clustering 이후 각각 구별되는 intensity value를 넣어줄 예정.
  pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>);
  pcl::fromROSMsg(*inputcloud, *cloud);

  //Visualizing에 필요한 Marker 선언
  visualization_msgs::MarkerArray BoxArray;
  visualization_msgs::Marker Box;

  visualization_msgs::MarkerArray WaypointArray;
  visualization_msgs::Marker Waypoint;

  visualization_msgs::MarkerArray LeftBoxArray;
  visualization_msgs::Marker LeftBox;

  visualization_msgs::MarkerArray RightBoxArray;
  visualization_msgs::Marker RightBox;

  //Boundingbox & Waypoitn Position Messsage 
  lidar_team_erp42::Boundingbox BoxPosition;
  lidar_team_erp42::Waypoint WaypointPosition;

  pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_xf(new pcl::PointCloud<pcl::PointXYZ>);
  pcl::PassThrough<pcl::PointXYZ> xfilter;
  xfilter.setInputCloud(cloud);
  xfilter.setFilterFieldName("x");
  xfilter.setFilterLimits(xMinROI, xMaxROI); 
  xfilter.setFilterLimitsNegative(false);
  xfilter.filter(*cloud_xf);

  pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_xyf(new pcl::PointCloud<pcl::PointXYZ>);
  pcl::PassThrough<pcl::PointXYZ> yfilter;
  yfilter.setInputCloud(cloud_xf);
  yfilter.setFilterFieldName("y");
  yfilter.setFilterLimits(yMinROI, yMaxROI);
  yfilter.setFilterLimitsNegative(false);
  yfilter.filter(*cloud_xyf);

  pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_xyzf(new pcl::PointCloud<pcl::PointXYZ>);
  pcl::PassThrough<pcl::PointXYZ> zfilter;
  zfilter.setInputCloud(cloud_xyf);
  zfilter.setFilterFieldName("z");
  zfilter.setFilterLimits(zMinROI, zMaxROI); // -0.62, 0.0
  zfilter.setFilterLimitsNegative(false);
  zfilter.filter(*cloud_xyzf);

  // //Voxel Grid를 이용한 DownSampling
  // pcl::VoxelGrid<pcl::PointXYZ> vg;    // VoxelGrid 선언
  // pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>); //Filtering 된 Data를 담을 PointCloud 선언
  // vg.setInputCloud(cloud);             // Raw Data 입력
  // vg.setLeafSize(0.5f, 0.5f, 0.5f); // 사이즈를 너무 작게 하면 샘플링 에러 발생
  // vg.filter(*cloud);          // Filtering 된 Data를 cloud PointCloud에 삽입
  
  // //RANSAC 알고리즘을 활용하여 바닥 제거
  // pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_f(new pcl::PointCloud<pcl::PointXYZ>);

  // pcl::SACSegmentation<pcl::PointXYZ> seg; //추출해 낼 Point의 indices를 만들어줌
  // pcl::PointIndices::Ptr inliers(new pcl::PointIndices);
  // pcl::ModelCoefficients::Ptr coefficients(new pcl::ModelCoefficients);
  // pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_plane(new pcl::PointCloud<pcl::PointXYZ>);
  // seg.setOptimizeCoefficients(true);
  // seg.setModelType(pcl::SACMODEL_PLANE);
  // seg.setMethodType(pcl::SAC_RANSAC);
  // seg.setMaxIterations(100);
  // seg.setDistanceThreshold(0.01);
  // seg.setInputCloud(cloud_xyzf);
  // seg.segment(*inliers, *coefficients);

  // //Extracting indices from a PointCloud
  // if (inliers->indices.size() != 0) {
  //   pcl::ExtractIndices<pcl::PointXYZ> extract; //index를 이용하여 해당하는 Point들을 추출
  //   extract.setInputCloud(cloud_xyzf);
  //   extract.setIndices(inliers);
  //   extract.setNegative(false);
  //   extract.filter(*cloud_plane);
  //   *cloud_xyzf = *cloud_f;
  // }

  //KD-Tree
  pcl::search::KdTree<pcl::PointXYZ>::Ptr tree(new pcl::search::KdTree<pcl::PointXYZ>);
  tree->setInputCloud(cloud_xyzf);

  //Segmentation
  vector<pcl::PointIndices> cluster_indices;
  
  //DBSCAN with Kdtree for accelerating
  DBSCANKdtreeCluster<pcl::PointXYZ> dc;
  dc.setCorePointMinPts(minPoints);   //Set minimum number of neighbor points
  dc.setClusterTolerance(epsilon); //Set Epsilon 
  dc.setMinClusterSize(minClusterSize);
  dc.setMaxClusterSize(maxClusterSize);
  dc.setSearchMethod(tree);
  dc.setInputCloud(cloud_xyzf);
  dc.extract(cluster_indices);

  pcl::PointCloud<pcl::PointXYZI> totalcloud_clustered;
  int cluster_id = 0;

  //각 Cluster 접근
  for (vector<pcl::PointIndices>::const_iterator it = cluster_indices.begin(); it != cluster_indices.end(); it++, cluster_id++) {
    pcl::PointCloud<pcl::PointXYZI> eachcloud_clustered;
    float cluster_counts = cluster_indices.size();

    //각 Cluster내 각 Point 접근
    for(vector<int>::const_iterator pit = it->indices.begin(); pit != it->indices.end(); ++pit) {

        pcl::PointXYZI tmp;
        tmp.x = cloud_xyzf->points[*pit].x;
        tmp.y = cloud_xyzf->points[*pit].y;
        tmp.z = cloud_xyzf->points[*pit].z;
        tmp.intensity = cluster_id%8;
        eachcloud_clustered.push_back(tmp);
        totalcloud_clustered.push_back(tmp);
    }

    //minPoint와 maxPoint 받아오기
    pcl::PointXYZI minPoint, maxPoint;
    pcl::getMinMax3D(eachcloud_clustered, minPoint, maxPoint);

    float x_len = abs(maxPoint.x - minPoint.x);   //직육면체 x 모서리 크기
    float y_len = abs(maxPoint.y - minPoint.y);   //직육면체 y 모서리 크기
    float z_len = abs(maxPoint.z - minPoint.z);   //직육면체 z 모서리 크기 
    float volume = x_len * y_len * z_len;         //직육면체 부피

    float center_x = (minPoint.x + maxPoint.x)/2; //직육면체 중심 x 좌표
    float center_y = (minPoint.y + maxPoint.y)/2; //직육면체 중심 y 좌표
    float center_z = (minPoint.z + maxPoint.z)/2; //직육면체 중심 z 좌표 

    float distance = sqrt(center_x * center_x + center_y * center_y); //장애물 <-> 차량 거리

    if ( (xMinBoundingBox < x_len && x_len < xMaxBoundingBox) && (yMinBoundingBox < y_len && y_len < yMaxBoundingBox) && (zMinBoundingBox < z_len && z_len < zMaxBoundingBox) ) {
      Box.header.frame_id = "velodyne";
      Box.header.stamp = ros::Time();
      Box.ns = cluster_counts; //ns = namespace
      Box.id = cluster_id; 
      Box.type = visualization_msgs::Marker::CUBE; //직육면체로 표시
      Box.action = visualization_msgs::Marker::ADD;

      Box.pose.position.x = center_x; 
      Box.pose.position.y = center_y;
      Box.pose.position.z = center_z;

      Box.pose.orientation.x = 0.0;
      Box.pose.orientation.y = 0.0;
      Box.pose.orientation.z = 0.0;
      Box.pose.orientation.w = 1.0;

      Box.scale.x = x_len;
      Box.scale.y = y_len;
      Box.scale.z = z_len;

      Box.color.a = 0.5; //직육면체 투명도, a = alpha
      Box.color.r = 1.0; //직육면체 색상 RGB값
      Box.color.g = 1.0;
      Box.color.b = 1.0;

      Box.lifetime = ros::Duration(0.1); //box 지속시간
      BoxArray.markers.emplace_back(Box);

      //Boundingbox Position Message
      BoxPosition.x = Box.pose.position.x;
      BoxPosition.y = Box.pose.position.y;
      BoxPosition.z = Box.pose.position.z;
      BoxPosition.distance = distance;
    }

    if (BoxArray.markers.size() > 1) {
      for (int i = 0; i < BoxArray.markers.size(); i++) {
        vector<float>().swap(obstacle);
        obstacle.emplace_back(BoxArray.markers[i].pose.position.x);
        obstacle.emplace_back(BoxArray.markers[i].pose.position.y);
        obstacle.emplace_back(BoxArray.markers[i].pose.position.z);
        obstacle.emplace_back(distance);
        obstacle_vec.emplace_back(obstacle);
      } 

      sort(obstacle_vec.begin(), obstacle_vec.end());

      // 두 개의 시작점이 왼쪽, 오른쪽에 각각 1개씩 잡히는 경우에만 실행. 한 라인에서 두 개의 시작점이 잡히는 경우 제외
      if (obstacle_vec[0][1] * obstacle_vec[1][1] < 0) { 

        // 왼쪽, 오른쪽 각각 시작점 잡기
        if (obstacle_vec[0][1] > 0) {
          obstacle_left.emplace_back(obstacle_vec[0]);
          obstacle_right.emplace_back(obstacle_vec[1]);

          // 두 개의 시작점을 제외한 나머지 라바콘들의 정보를 buffer에 저장
          obstacle_buffer.resize(obstacle_vec.size()-2);
          copy(obstacle_vec.begin()+2, obstacle_vec.end(), obstacle_buffer.begin());
        }
        else {
          obstacle_left.emplace_back(obstacle_vec[1]);
          obstacle_right.emplace_back(obstacle_vec[0]);

          // 두 개의 시작점을 제외한 나머지 라바콘들의 정보를 buffer에 저장
          obstacle_buffer.resize(obstacle_vec.size()-2);
          copy(obstacle_vec.begin()+2, obstacle_vec.end(), obstacle_buffer.begin());
        }

        // buffer를 탐색하며 왼쪽에 들어갈 라바콘과 오른쪽에 들어갈 라바콘 구분 후 배열에 삽입
        for (int i = 0; i < obstacle_buffer.size(); i++) {
          float left_distance_c2c = getDistanceC2C(obstacle_buffer[i], obstacle_left.back());
          float right_distacne_c2c = getDistanceC2C(obstacle_buffer[i], obstacle_right.back());

          if (left_distance_c2c < right_distacne_c2c) {
            obstacle_left.emplace_back(obstacle_buffer[i]);
            sort(obstacle_left.begin(), obstacle_left.end());
          }
          else {
            obstacle_right.emplace_back(obstacle_buffer[i]);
            sort(obstacle_right.begin(), obstacle_right.end());
          }
        }

        // Waypoint Array 구성 -> 왼쪽, 오른쪽 중 작은 사이즈인 배열의 사이즈를 기준으로 비교
        if (obstacle_left.size() < obstacle_right.size()) {
          for (int i = 0; i < obstacle_left.size(); i++) {
            if (getTangentC2C(obstacle_left[i], obstacle_right[i]) > TANGENT) {
              vector<float> tmp_vec;
              tmp_vec.emplace_back( (obstacle_left[i][0] + obstacle_right[i][0]) / 2 );
              tmp_vec.emplace_back( (obstacle_left[i][1] + obstacle_right[i][1]) / 2 );
              tmp_vec.emplace_back( (obstacle_left[i][2] + obstacle_right[i][2]) / 2 );

              waypoint_arr.emplace_back(tmp_vec);
            }
          }
        }
        else {
          for (int i = 0; i < obstacle_right.size(); i++) {
            if (getTangentC2C(obstacle_left[i], obstacle_right[i]) > TANGENT) {
              vector<float> tmp_vec;
              tmp_vec.emplace_back( (obstacle_left[i][0] + obstacle_right[i][0]) / 2 );
              tmp_vec.emplace_back( (obstacle_left[i][1] + obstacle_right[i][1]) / 2 );
              tmp_vec.emplace_back( (obstacle_left[i][2] + obstacle_right[i][2]) / 2 );

              waypoint_arr.emplace_back(tmp_vec);
            }
          }
        }
        
        // Print for Debugging
        // cout << "LEFT: ";
        // for (int i = 0; i < obstacle_left.size(); i++) {
        //   cout << "[" << obstacle_left[i][0] << ", " << obstacle_left[i][1] << "], ";
        // }
        // cout << "\n";

        // cout << "RIGHT: ";
        // for (int i = 0; i < obstacle_right.size(); i++) {
        //   cout << "[" << obstacle_right[i][0] << ", " << obstacle_right[i][1] << "], ";
        // }
        // cout << "\n";

        // cout << "WAYPOINT: ";
        // for (int i = 0; i < waypoint_arr.size(); i++) {
        //   cout << "[" << waypoint_arr[i][0] << ", " << waypoint_arr[i][1] << "], ";
        // }

        // cout << "\n\n";

        // Visualization
        for (int i = 0; i < obstacle_left.size(); i++) {
          LeftBox.header.frame_id = "velodyne";
          LeftBox.header.stamp = ros::Time();
        
          LeftBox.id = cluster_id*123; 
          LeftBox.type = visualization_msgs::Marker::CYLINDER; //직육면체로 표시
          LeftBox.action = visualization_msgs::Marker::ADD;

          LeftBox.pose.position.x = obstacle_left[i][0]; 
          LeftBox.pose.position.y = obstacle_left[i][1];
          LeftBox.pose.position.z = obstacle_left[i][2];

          LeftBox.scale.x = 0.5;
          LeftBox.scale.y = 0.5;
          LeftBox.scale.z = 0.8;

          LeftBox.color.a = 0.5; //직육면체 투명도, a = alpha
          LeftBox.color.r = 1.0; //직육면체 색상 RGB값
          LeftBox.color.g = 1.0;
          LeftBox.color.b = 0.0;

          LeftBox.lifetime = ros::Duration(0.1); //box 지속시간
          LeftBoxArray.markers.emplace_back(LeftBox);
        }

        for (int i = 0; i < obstacle_right.size(); i++) {
          RightBox.header.frame_id = "velodyne";
          RightBox.header.stamp = ros::Time();
        
          RightBox.id = cluster_id*234; 
          RightBox.type = visualization_msgs::Marker::CYLINDER; //직육면체로 표시
          RightBox.action = visualization_msgs::Marker::ADD;

          RightBox.pose.position.x = obstacle_right[i][0]; 
          RightBox.pose.position.y = obstacle_right[i][1];
          RightBox.pose.position.z = obstacle_right[i][2];

          RightBox.scale.x = 0.5;
          RightBox.scale.y = 0.5;
          RightBox.scale.z = 0.8;

          RightBox.color.a = 0.5; //직육면체 투명도, a = alpha
          RightBox.color.r = 0.0; //직육면체 색상 RGB값
          RightBox.color.g = 0.0;
          RightBox.color.b = 1.0;

          RightBox.lifetime = ros::Duration(0.1); //box 지속시간
          RightBoxArray.markers.emplace_back(RightBox);
        }
    
        for (int i = 0; i < waypoint_arr.size(); i++) {
          Waypoint.header.frame_id = "velodyne";
          Waypoint.header.stamp = ros::Time();
        
          Waypoint.id = cluster_id*345; 
          Waypoint.type = visualization_msgs::Marker::SPHERE; //직육면체로 표시
          Waypoint.action = visualization_msgs::Marker::ADD;

          Waypoint.pose.position.x = waypoint_arr[i][0]; 
          Waypoint.pose.position.y = waypoint_arr[i][1];
          Waypoint.pose.position.z = waypoint_arr[i][2];

          Waypoint.scale.x = 0.5;
          Waypoint.scale.y = 0.5;
          Waypoint.scale.z = 0.5;

          Waypoint.color.a = 1.0; //직육면체 투명도, a = alpha
          Waypoint.color.r = 1.0; //직육면체 색상 RGB값
          Waypoint.color.g = 0.0;
          Waypoint.color.b = 0.0;

          Waypoint.lifetime = ros::Duration(0.1); //box 지속시간
          WaypointArray.markers.emplace_back(Waypoint);
          
          WaypointPosition.x_arr[i] = (waypoint_arr[i][0]);
          WaypointPosition.y_arr[i] = (waypoint_arr[i][1]);
        }
        WaypointPosition.cnt = waypoint_arr.size();

      } //endif(obstacle_vec[0][1] * obstacle_vec[1][1] < 0)

    
      // 두 개의 시작점이 한 라인에서 잡힌 경우
      else {
        // cout << "Oops!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
        // cout << obstacle_vec[0][1] << "//" << obstacle_vec[1][1] << "===" << obstacle_vec[0][1] * obstacle_vec[1][1] << '\n';
      } 

      // 다음 탐색을 위한 배열 초기화
      vector< vector<float> >().swap(obstacle_vec);
      vector< vector<float> >().swap(obstacle_buffer);
      vector< vector<float> >().swap(obstacle_left);
      vector< vector<float> >().swap(obstacle_right);
      vector< vector<float> >().swap(waypoint_arr);

    }// endif(BoxArray.markers.size() > 1)
    
    cluster_id++; //intensity 증가

  }
  
  //Convert To ROS data type
  pcl::PCLPointCloud2 cloud_p;
  pcl::toPCLPointCloud2(totalcloud_clustered, cloud_p);

  sensor_msgs::PointCloud2 cluster;
  pcl_conversions::fromPCL(cloud_p, cluster);
  cluster.header.frame_id = "velodyne";

  pcl::PCLPointCloud2 cloud_cropbox;
  pcl::toPCLPointCloud2(*cloud_xyzf, cloud_cropbox);

  sensor_msgs::PointCloud2 cropbox;
  pcl_conversions::fromPCL(cloud_cropbox, cropbox);
  cropbox.header.frame_id = "velodyne";


  clusterPub.publish(cluster);
  boundingBoxMarkerPub.publish(BoxArray);
  waypointMarkerPub.publish(WaypointArray);
  boundingBoxPosePub.publish(BoxPosition);
  waypointPosePub.publish(WaypointPosition);
  leftConesMarkerPub.publish(LeftBoxArray);
  rightConesMarkerPub.publish(RightBoxArray);
  cropboxPub.publish(cropbox);
  
}

int main(int argc, char **argv) {
  ros::init(argc, argv, "obstacle_detector");
  ros::NodeHandle nh;

  dynamic_reconfigure::Server<lidar_team_erp42::hyper_parameterConfig> server;
  dynamic_reconfigure::Server<lidar_team_erp42::hyper_parameterConfig>::CallbackType f;

  f = boost::bind(&dynamicParamCallback, _1, _2);
  server.setCallback(f);

  ros::Subscriber rawDataSub = nh.subscribe("/velodyne_points", 1, cloud_cb);  // velodyne_points 토픽 구독. velodyne_points = 라이다 raw data

  clusterPub = nh.advertise<sensor_msgs::PointCloud2>("/cluster", 0.001);                  
  boundingBoxMarkerPub = nh.advertise<visualization_msgs::MarkerArray>("/boundingbox_marker", 0.001); 
  waypointMarkerPub = nh.advertise<visualization_msgs::MarkerArray>("/waypoint_marker", 0.001);    
  boundingBoxPosePub = nh.advertise<lidar_team_erp42::Boundingbox>("/boundingbox_position", 0.001);    
  waypointPosePub = nh.advertise<lidar_team_erp42::Waypoint>("/waypoint_position", 0.001);          
  leftConesMarkerPub = nh.advertise<visualization_msgs::MarkerArray>("/leftbox_marker", 0.001);
  rightConesMarkerPub = nh.advertise<visualization_msgs::MarkerArray>("/rightbox_marker", 0.001);
  cropboxPub = nh.advertise<sensor_msgs::PointCloud2>("/cropbox", 0.001); 
  
  ros::spin();
 
  return 0;
}