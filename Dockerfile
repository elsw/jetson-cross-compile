# syntax=docker/dockerfile:1
# Image source is from https://github.com/dusty-nv/jetson-containers/blob/master/Dockerfile.ros.melodic
# Noetic is not availble on the JETSON yet (unless installing from source), so using melodic
FROM dustynv/ros:melodic-ros-base-l4t-r32.5.0

ENV ROS_DISTRO=melodic
ENV PKG=ros-${ROS_DISTRO}-

#
# Update Outdated Keys
#
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN sudo apt update

#
# Install Common Extra packages to save time with the rosdep step at build time
#
COPY dependancies.txt /dependancies.txt
COPY run_deps.sh /run_deps.sh
RUN chmod +x /run_deps.sh
RUN /run_deps.sh ${ROS_DISTRO}


WORKDIR /catkin_ws

COPY build.sh /build.sh
RUN chmod +x /build.sh

CMD ["/build.sh"]
