<!--
 * @Description: 
 * @Author: Sauron
 * @Date: 2023-11-17 20:50:13
 * @LastEditTime: 2024-02-03 10:07:04
 * @LastEditors: Sauron
-->
# VecBench is a vehicle computing benchmark for intelligent vehicles, it is based on Autoware.
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
- [Range Estimation](https://github.com/qirenwang/range_estimation)
- [Battery Diagnostic](https://github.com/yongtaoyao/li_battery_ws)
- Multi-Tracking

## Metrics
TOD
<!--
# Autoware - the world's leading open-source software project for autonomous driving

![Autoware_RViz](https://user-images.githubusercontent.com/63835446/158918717-58d6deaf-93fb-47f9-891d-e242b02cba7b.png)
[![Discord](https://img.shields.io/discord/953808765935816715?label=Autoware%20Discord&style=for-the-badge)](https://discord.gg/Q94UsPvReQ)

Autoware is an open-source software stack for self-driving vehicles, built on the [Robot Operating System (ROS)](https://www.ros.org/). It includes all of the necessary functions to drive an autonomous vehicles from localization and object detection to route planning and control, and was created with the aim of enabling as many individuals and organizations as possible to contribute to open innovations in autonomous driving technology.

![Autoware architecture](https://static.wixstatic.com/media/984e93_552e338be28543c7949717053cc3f11f~mv2.png/v1/crop/x_0,y_1,w_1500,h_879/fill/w_863,h_506,al_c,usm_0.66_1.00_0.01,enc_auto/Autoware-GFX_edited.png)

## Documentation

To learn more about using or developing Autoware, refer to the [Autoware documentation site](https://autowarefoundation.github.io/autoware-documentation/main/). You can find the source for the documentation in [autowarefoundation/autoware-documentation](https://github.com/autowarefoundation/autoware-documentation).

## Repository overview

- [autowarefoundation/autoware](https://github.com/autowarefoundation/autoware)
  - Meta-repository containing `.repos` files to construct an Autoware workspace.
  - It is anticipated that this repository will be frequently forked by users, and so it contains minimal information to avoid unnecessary differences.
- [autowarefoundation/autoware_common](https://github.com/autowarefoundation/autoware_common)
  - Library/utility type repository containing commonly referenced ROS packages.
  - These packages were moved to a separate repository in order to reduce CI execution time
- [autowarefoundation/autoware.core](https://github.com/autowarefoundation/autoware.core)
  - Main repository for high-quality, stable ROS packages for Autonomous Driving.
  - Based on [Autoware.Auto](https://gitlab.com/autowarefoundation/autoware.auto/AutowareAuto) and [Autoware.Universe](https://github.com/autowarefoundation/autoware.universe).
- [autowarefoundation/autoware.universe](https://github.com/autowarefoundation/autoware.universe)
  - Repository for experimental, cutting-edge ROS packages for Autonomous Driving.
  - Autoware Universe was created to make it easier for researchers and developers to extend the functionality of Autoware Core
- [autowarefoundation/autoware_launch](https://github.com/autowarefoundation/autoware_launch)
  - Launch configuration repository containing node configurations and their parameters.
- [autowarefoundation/autoware-github-actions](https://github.com/autowarefoundation/autoware-github-actions)
  - Contains [reusable GitHub Actions workflows](https://docs.github.com/ja/actions/learn-github-actions/reusing-workflows) used by multiple repositories for CI.
  - Utilizes the [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) concept.
- [autowarefoundation/autoware-documentation](https://github.com/autowarefoundation/autoware-documentation)
  - Documentation repository for Autoware users and developers.
  - Since Autoware Core/Universe has multiple repositories, a central documentation repository is important to make information accessible from a single place.

## Using Autoware.AI

If you wish to use Autoware.AI, the previous version of Autoware based on ROS 1, switch to [autoware-ai](https://github.com/autowarefoundation/autoware_ai) repository. However, be aware that Autoware.AI has reached the end-of-life as of 2022, and we strongly recommend transitioning to Autoware Core/Universe for future use.

## Contributing

- [There is no formal process to become a contributor](https://github.com/autowarefoundation/autoware-projects/wiki#contributors) - you can comment on any [existing issues](https://github.com/autowarefoundation/autoware.universe/issues) or make a pull request on any Autoware repository!
  - Make sure to follow the [Contribution Guidelines](https://autowarefoundation.github.io/autoware-documentation/main/contributing/).
  - Take a look at Autoware's [various working groups](https://github.com/autowarefoundation/autoware-projects/wiki#working-group-list) to gain an understanding of any work in progress and to see how projects are managed.
- If you have any technical questions, you can start a discussion in the [Q&A category](https://github.com/autowarefoundation/autoware/discussions/categories/q-a) to request help and confirm if a potential issue is a bug or not.

## Useful resources

- [Autoware Foundation homepage](https://www.autoware.org/)
- [Support guidelines](https://autowarefoundation.github.io/autoware-documentation/main/support/support-guidelines/)
-->