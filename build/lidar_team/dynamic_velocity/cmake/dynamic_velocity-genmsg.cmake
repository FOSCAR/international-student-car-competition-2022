# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "dynamic_velocity: 1 messages, 0 services")

set(MSG_I_FLAGS "-Idynamic_velocity:/home/foscar/ISCC_2022/src/lidar_team/dynamic_velocity/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators

add_custom_target(dynamic_velocity_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/foscar/ISCC_2022/src/lidar_team/dynamic_velocity/msg/Velocity.msg" NAME_WE)
add_custom_target(_dynamic_velocity_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "dynamic_velocity" "/home/foscar/ISCC_2022/src/lidar_team/dynamic_velocity/msg/Velocity.msg" ""
)

#
#  langs = 
#


