cd $VCBENCH_HOME
###
 # @Description: 
 # @Author: Sauron
 # @Date: 2023-11-17 21:50:00
 # @LastEditTime: 2023-11-17 22:54:52
 # @LastEditors: Sauron
### 
if [ ! -d "$VCBENCH_HOME/src" ]; then
	    mkdir src
fi

read -p "Do you want to remove ROS2 before reinstall? (y/n) " answer_ros
case $answer_ros in
    [Yy]* ) sudo apt-get purge -y ros-*; echo "ROS 2 removed";;
    [Nn]* ) echo "ROS 2 not removed";;
    * ) echo "Invalid response"; exit 1;;
esac

read -p "Do you want to remove NVIDIA-related pkgs before reinstall? (y/n) " answer_nvidia
case $answer_nvidia in
    [Yy]* ) sudo apt-get purge -y 'nvidia-*' 'cuda-*'; echo "NVIDIA related pkgs removed";;
    [Nn]* ) echo "NVIDIA related pkgs not removed";;
    * ) echo "Invalid response"; exit 1;;
esac

./setup-dev-env.sh
vcs import src < autoware.repos
source /opt/ros/humble/setup.bash
rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
source install/setup.bash

cd $VCBENCH_HOME/dependencies/
git clone https://github.com/hatem-darweesh/op_bridge.git -b ros2
git clone https://github.com/hatem-darweesh/op_agent.git -b ros2