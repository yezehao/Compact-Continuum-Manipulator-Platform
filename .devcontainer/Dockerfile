FROM osrf/ros:noetic-desktop-full-focal
RUN apt-get -y update && apt-get -y upgrade \
    && apt-get -y install \
    build-essential \
    cmake \
    git \
    vim \
    python3-dev \
    python3-pip \
    python3-numpy

RUN apt-get -y update && apt-get -y install \
    ros-noetic-rviz \
    ros-noetic-gazebo-ros-pkgs \
    ros-noetic-gazebo-ros-control \
    ros-noetic-catkin \
    python3-catkin-tools \
    ros-noetic-turtlebot3-msgs

RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc
RUN echo "source /workspaces/Compact-Continuum-Manipulator-Platform/catkin_ws/devel/setup.bash" >> /root/.bashrc