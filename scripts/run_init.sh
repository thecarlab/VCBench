#!/bin/bash
###
 # @Description: 
 # @Author: Sauron
 # @Date: 2023-11-15 21:54:23
 # @LastEditTime: 2023-11-19 23:29:43
 # @LastEditors: Sauron
### 

#export VCBENCH_HOME=$(pwd)
export VCBENCH_HOME=/home/sauron/autoware
CARLA_VERSION=0.9.15
export CARLA_HOME=$VCBENCH_HOME/dependencies/CARLA_$CARLA_VERSION
export CARLA_ROOT=$CARLA_HOME
CARLA_EGG=$(ls $CARLA_HOME/PythonAPI/carla/dist/carla*py3*egg)
export PYTHONPATH=$PYTHONPATH:$VCBENCH_HOME:/$VCBENCH_HOME/dependencies/:$CARLA_EGG:$CARLA_HOME/PythonAPI/carla/:$CARLA_HOME/PythonAPI/util:$CARLA_HOME/PythonAPI/carla/agents:$VCBENCH_HOME/dependencies/lanenet/


export SCENARIO_RUNNER_ROOT=$VCBENCH_HOME/dependencies/scenario_runner
export LEADERBOARD_ROOT=$VCBENCH_HOME/dependencies/op_bridge
export TEAM_CODE_ROOT=$VCBENCH_HOME/dependencies/op_agent

# ros2 init
source /opt/ros/humble/setup.bash
# autoware init
source $VCBENCH_HOME/install/setup.bash
