<!--
 * @Description: 
 * @Author: Sauron
 * @Date: 2023-11-23 10:19:15
 * @LastEditTime: 2023-11-23 10:22:09
 * @LastEditors: Sauron
-->
# You shouldn't encounter these issues, check your system version and check if you are in a virtual env(like conda)

# Potential issues:
1. "rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO" fails to install some libs: *run "pip3 install -U xxx" directly then run "rosdep install" again*.
2. "undefined reference problem for yabloc_common, costmap_generator, nebula_examples, nebula_tests, map_loader, grid_map_utils, probabilistic_occupancy_grid_map, ar_tag_based_localizer, yabloc_image_processing, yabloc_pose_initializer, ground_segmentation, yabloc_particle_filter, behavior_velocity_occlusion_spot_module,lanelet2_map_preprocessor,obstacle_velocity_limiter, static_centerline_optimizer":*add contents(TIFF, CURL, UUID, ) to their CMakeLists.txt,* example:
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