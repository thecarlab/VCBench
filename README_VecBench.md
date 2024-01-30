<!--
 * @Description: 
 * @Author: Sauron
 * @Date: 2023-11-15 17:50:35
 * @LastEditTime: 2024-01-30 00:01:39
 * @LastEditors: Sauron
-->
# VecBench

## Requirement (see amd64.env for detail)
Ubuntu 22.04
ROS2 Humble
CUDA 12
python 3.10+
(Carla 0.9.13+)

## Setup
```shell
conda deactivate #if you have a conda environment
cd path_to_VecBench # $HOME/HydraOS_workspace/VecBench now, pls create a soft link first
export HYDRAOS=$HOME/HydraOS_workspace # put this in your ~/.bashrc if you want

# install Autoware, see: https://autowarefoundation.github.io/autoware-documentation/main/installation/autoware/source-installation/
./setup-dev-env.sh # you should enable all the options and make sure this step is completed successfully
mkdir src
vcs import src < autoware.repos
source /opt/ros/humble/setup.bash # if you install humble through source install, source the setup.bash in your_humble/install/
rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
# try Autoware
gdown -O $HYDRAOS/autoware_map/ 'https://docs.google.com/uc?export=download&id=1499_nsbUbIeturZaDj7jhUownh5fvXHd'
unzip -d $HYDRAOS/autoware_map $HYDRAOS/autoware_map/sample-map-planning.zip

source $HYDRAOS/VecBench/install/setup.bash # put this in your ~/.bashrc if you want
ros2 launch autoware_launch planning_simulator.launch.xml map_path:=$HYDRAOS/autoware_map/sample-map-planning vehicle_model:=sample_vehicle sensor_model:=sample_sensor_kit

# (optional) ROS2 Humble source install see: https://docs.ros.org/en/humble/Installation/Alternatives/Ubuntu-Development-Setup.html
# (optional) Carla&UE4 source install see: https://carla.readthedocs.io/en/latest/build_linux/, TODO: bridge carla and autoware
```

## Add your own module
Edit autoware.repos, add your module's address. For example, you want to add a battery control module named battery_control, you can add:
```shell
vehicle/battery_control:
    type: git
    url: https://github.com/autowarefoundation/battery_control.git
    version: main
```
which means your battery_control repo's main branch will be cloned to VecBench/src/vehicle/battery_control. Make sure that your module should be a ROS2 Humble package(package.xml and CMakeLists.txt exist), and it could be compiled by colcon. If your module depends on other github repos(which could not be added to package.xml), you can add a file named build_depends.repos to your module(an example [here](https://github.com/tier4/tier4_ad_api_adaptor/blob/tier4/universe/build_depends.repos)).

## Available Modules
- [Sensing function of Autoware](./VecBench_docs/Sensing.md)
- Range Estimation
- Battery
- Multi-Tracking