#include <vector>
#include <cmath>
#include <fstream>
#include <cstdlib>
#include <unistd.h>
#include <ctime>
#include <chrono>
#include <algorithm>
#include <race/drive_values.h>
#include <lidar_team_erp42/Delivery.h>
#include <darknet_ros_msgs/BoundingBox.h>
#include <darknet_ros_msgs/BoundingBoxes.h>
#include <vision_distance/DeliveryArray.h>
#include <tf/transform_broadcaster.h>
#include <ros/ros.h>

using namespace std;

int mode = 9;
int mission_flag = 0;

int is_delivery_obs_stop_detected = 1;

int a_max_index = -1;
int b_max_index = -1;

int b_idx_cnt = 0;

bool a_cnt_flag = false;
bool b_cnt_flag = false;

vector<int> a_cnt = {0, 0 ,0};
vector<int> b_cnt = {0, 0, 0};

double delivery_x_dist;
double delivery_angle;

ros::Publisher drive_msg_pub;


bool compare2(vision_distance::Delivery a, vision_distance::Delivery b) {
  return a.dist_y < b.dist_y ? true : false;
}

void callbackFromDeliveryObstacleStop(const lidar_team_erp42::Delivery& msg) {
  if ((msg.x != 0 &&  msg.angle != 0) && (mode == 10 || mode == 20)) {
    // msg.angle >=95 수정
    if (msg.x > -0.05 && msg.x < 0.16) {
      is_delivery_obs_stop_detected = 1;
      cout << "STOP CHANGE !!!!!!!!" << is_delivery_obs_stop_detected << '\n';
    }
  }
}


void callbackFromDelivery(const vision_distance::DeliveryArray& msg){
  vector<vision_distance::Delivery> deliverySign = msg.visions;

  // B Area
  if (mode == 20 && (mission_flag == 1 || mission_flag == 2 || mission_flag == 3)){
    sort(deliverySign.begin(), deliverySign.end(), compare2);
    
    if(deliverySign.size() > 0){
      if(deliverySign[0].flag < 4){
        //std::cout << b_cnt << std::endl;
        b_cnt[deliverySign[0].flag-1] += 1;
      }
    }
  }

  // A Area
  if (mode == 10 && mission_flag == 0){
    sort(deliverySign.begin(), deliverySign.end(), compare2);
    
    if(deliverySign.size() > 0){
      if(deliverySign[0].flag >= 4){
        a_cnt[deliverySign[0].flag-4] += 1;
        cout << "deliverySign: " << deliverySign[0].flag-4 << '\n';
        cout << "a_cnt: " << a_cnt[deliverySign[0].flag-4] << '\n';
      }
    }
  }
}

void publishControlMsg(double throttle, double steering) {
  race::drive_values drive_msg;
  drive_msg.throttle = throttle;
  drive_msg.steering = steering;
  drive_msg_pub.publish(drive_msg);
}


int main(int argc, char **argv) {
    ros::init(argc, argv, "straight_test");
    ros::NodeHandle nh_;


    ros::Subscriber delivery_obs_sub1 = nh_.subscribe("delivery_obs_calc", 1, callbackFromDeliveryObstacleStop);
    ros::Subscriber delivery_sub = nh_.subscribe("delivery", 1, callbackFromDelivery);

    drive_msg_pub = nh_.advertise<race::drive_values>("control_value", 1);

    time_t start_time, present_time;

    start_time = time(NULL); 

    while (mode == 9) {
        present_time = time(NULL);
        if (present_time - start_time > 8) {
            mode = 10;
            break;
        }
        
        publishControlMsg(3, 0);

        ROS_INFO("MODE = 9");
    }


    start_time = time(NULL);

    while (mode == 10) {
        present_time = time(NULL);
        if (present_time - start_time > 15) {
            mode = 11;
            break;
        }

        if (mission_flag == 0 && is_delivery_obs_stop_detected) {
            mission_flag = 1;

            for (int i = 0; i < 55; i++) {
            publishControlMsg(0, 0);
            usleep(100000);
            }
        }

        ROS_INFO("MODE = 10");
    }

    start_time = time(NULL);

    while (mode == 11) {
        present_time = time(NULL);
        if (present_time - start_time > 3) {
            mode = 19;
            break;
        }

        a_max_index = max_element(a_cnt.begin(), a_cnt.end()) - a_cnt.begin();

        publishControlMsg(5, 0);

        ROS_INFO("MODE = 11");
    }


    start_time = time(NULL);

    while (mode == 19) {
        present_time = time(NULL);
        if (present_time - start_time > 3) {
            mode = 20;
            break;
        }

        publishControlMsg(5, 0);

        ROS_INFO("MODE = 19");
    }


    start_time = time(NULL);

    while (mode == 20) {
        present_time = time(NULL);
        if (present_time - start_time > 20) {
            break;
        }
        
        ROS_INFO("MISSION_FLAG=(%d) A_INDEX(%d)  B_INDEX(%d)", mission_flag, a_max_index, b_max_index);
        ROS_INFO("B1=%d, B2=%d, B3=%d", b_cnt[0],b_cnt[1], b_cnt[2]);
        
        // case 2) vision_distance + gps 로직
        //0

        if(mission_flag == 0){
            mission_flag = 1;
        }
        else if(mission_flag == 22){
            mission_flag = 2;
        }
        else if(mission_flag == 33){
            mission_flag = 3;
        }

        
        if ( (mission_flag == 1 || mission_flag == 2 || mission_flag == 3) && is_delivery_obs_stop_detected) {
            is_delivery_obs_stop_detected = 0;
            b_max_index = max_element(b_cnt.begin(), b_cnt.end()) - b_cnt.begin();

            ROS_INFO("MISSION_FLAG_FINAL=(%d) A_INDEX_FINAL(%d)  B_INDEX_FINAL(%d)", mission_flag, a_max_index, b_max_index);
            ROS_INFO("HOW MANY B COUNT=%d",  b_cnt[b_max_index] );

            if (a_max_index == b_max_index) {
                ROS_INFO("@@@@@@@@@@@@@@@ DELIVERY COMPLETE @@@@@@@@@@@@@@");

                // Max flag on
                for (int i = 0; i < 55; i++) {
                    publishControlMsg(0, 0);
                    usleep(100000);  // 0.1초
                }
                mission_flag = 100;
            } 

            else {
                b_cnt = {0, 0, 0};
                if(mission_flag == 1){ mission_flag = 22; }
                else if(mission_flag == 2){ mission_flag = 33; }
            }
        }

        publishControlMsg(6, 0);
        
    }
    
    ros::spin();
    
    return 0;
}

