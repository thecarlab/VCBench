<!--
 * @Description: 
 * @Author: Sauron
 * @Date: 2023-11-15 17:50:35
 * @LastEditTime: 2023-11-17 22:54:55
 * @LastEditors: Sauron
-->
# VCBench

## Requirement
Ubuntu 22.04(20.04)
ROS2 Humble
CUDA 12(11)

## Setup
```shell
conda create -n vcbench python=3.8 #create a new python environment
conda activate vcbench
cd path_to_VCBench
./install.sh #install what you need
```

## Install Autoware
Follow the [source install guide](https://autowarefoundation.github.io/autoware-documentation/main/installation/autoware/source-installation/) of Autoware to install Autoware. Add the following content to autoware.repos:
```yaml
universe/external/open_planner:
    type: git
    url: https://github.com/ZATiTech/open_planner.git
    version: main
```

Potential problems:
1. "./setup-dev-env.sh" fails to download or update: *execute it again*.
2. "rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO" fails to install some libs: *run "pip3 install -U xxx" directly then run "rosdep install" again*.
3. "undefined reference problem for yabloc_common, costmap_generator, nebula_examples, nebula_tests, map_loader, grid_map_utils, probabilistic_occupancy_grid_map, ar_tag_based_localizer, yabloc_image_processing, yabloc_pose_initializer, ground_segmentation, yabloc_particle_filter, behavior_velocity_occlusion_spot_module,lanelet2_map_preprocessor,obstacle_velocity_limiter, static_centerline_optimizer":*add contents(TIFF, CURL, UUID, ) to their CMakeLists.txt,* example:
```cmake
find_package(PkgConfig REQUIRED)
pkg_check_modules(UUID REQUIRED uuid)
find_package(CURL REQUIRED)
find_package(TIFF REQUIRED)

include_directories(${UUID_INCLUDE_DIRS}) # since UUID is found by pkg, so you may need to tell it where to find its headers

target_link_libraries(your_target ${UUID_LIBRARIES} ${CURL_LIBRARIES} ${TIFF_LIBRARIES})
link_libraries(
  ${CURL_LIBRARIES}
  ${TIFF_LIBRARIES}
)
ament_target_dependencies(your_target 
CURL
TIFF
)
```

## Run Carla
```shell
conda activate vcbench
cd path_to_VCBench
. scripts/run_init.sh
./scripts/run_carla.sh #[port, default 2000] [offscreen, default false]
```

## Run Autoware
Follow the [tutorial](https://autowarefoundation.github.io/autoware-documentation/main/tutorials/ad-hoc-simulation/planning-simulation/) to test Autoware.
Potential Issues:
1. If you run autoware in a VSCode terminal, you may encounter "undefined symbol" problem: *execute "uset GTK_PATH"*