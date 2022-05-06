# syntax=docker/dockerfile:1
# Image source is from https://github.com/dusty-nv/jetson-containers/blob/master/Dockerfile.ros.melodic
# Noetic is not availble on the JETSON yet (unless installing from source), so using melodic
FROM arm32v7/ros:melodic

ENV ROS_DISTRO=melodic
ENV PKG=ros-${ROS_DISTRO}-

#
# Update Outdated Keys
#
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
#RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN sudo apt update

#
# Install Common Extra packages to save time with the rosdep step at build time
#
RUN apt-get install -y --no-install-recommends ${PKG}joy ${PKG}pcl-ros ${PKG}tf ${PKG}robot-pose-ekf ${PKG}laser-filters ${PKG}nav-core \
						 ${PKG}base-local-planner ${PKG}costmap-2d ${PKG}voxel-grid ${PKG}dwa-local-planner ${PKG}base-local-planner \
						 ${PKG}joint-state-publisher ${PKG}tf-conversions ${PKG}imu-filter-madgwick ${PKG}robot-localization \
						 ${PKG}eigen-conversions ${PKG}robot-state-publisher

WORKDIR /catkin_ws

COPY build.sh /build.sh
RUN chmod +x /build.sh

CMD ["/build.sh"]
