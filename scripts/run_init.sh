#!/bin/bash
###
 # @Description: 
 # @Author: Sauron
 # @Date: 2023-11-15 21:54:23
 # @LastEditTime: 2023-11-17 22:54:49
 # @LastEditors: Sauron
### 

export VCBENCH_HOME=$(pwd)
export CARLA_HOME=$VCBENCH_HOME/dependencies/CARLA_0.9.10.1
CARLA_EGG=$(ls $CARLA_HOME/PythonAPI/carla/dist/carla*py3*egg)
export PYTHONPATH=$PYTHONPATH:$VCBENCH_HOME:/$VCBENCH_HOME/dependencies/:$CARLA_EGG:$CARLA_HOME/PythonAPI/carla/:$VCBENCH_HOME/dependencies/lanenet/
# export autoware

# ros2 init
source /opt/ros/humble/setup.bash
# autoware init
source install/setup.bash
