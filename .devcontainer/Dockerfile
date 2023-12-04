FROM osrf/ros:noetic-desktop-full-focal
RUN apt-get -y update && apt-get -y upgrade \
    && apt-get -y install \
    build-essential \
    cmake \
    git \
    python3-dev \
    python3-pip \
    python3-numpy

RUN apt-get -y update && apt-get -y install \
    ros-noetic-rviz

RUN apt-get -y update && apt-get -y install \
    ros-noetic-gazebo-ros-pkgs \
    ros-noetic-gazebo-ros-control

RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc