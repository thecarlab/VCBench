#!/bin/bash
###
 # @Description: 
 # @Author: Sauron
 # @Date: 2024-01-29 10:58:51
 # @LastEditTime: 2024-01-29 16:23:50
 # @LastEditors: Sauron
### 

# record topics for sensing
ros2 bag record --use-sim-time /clock /map/map_projector_info /tf /tf_static /sensing/gnss/ublox/fix_velocity /sensing/gnss/ublox/nav_sat_fix /sensing/gnss/ublox/navpvt /sensing/imu/tamagawa/imu_raw /sensing/lidar/left/velodyne_packets /sensing/lidar/right/velodyne_packets /sensing/lidar/top/velodyne_packets /vehicle/status/control_mode /vehicle/status/gear_status /vehicle/status/steering_status /vehicle/status/velocity_status