FROM ubuntu:20.04
RUN apt update && apt upgrade -y
RUN apt install -y curl lsb-release gnupg
RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Moscow apt-get -y install tzdata keyboard-configuration
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt update && apt install -y ros-noetic-desktop-full ros-noetic-realsense2-camera
RUN apt install -y git xcb
# RUN source /opt/ros/noetic/setup.bash

ENV CATKIN_WS=/root/catkin_ws
ENV PKG_CONFIG_PATH=/opt/ros/noetic/lib/pkgconfig
ENV ROS_PACKAGE_PATH=/opt/ros/noetic/share
ENV ROS_ETC_DIR=/opt/ros/noetic/etc/ros
ENV CMAKE_PREFIX_PATH=/opt/ros/noetic
ENV PYTHONPATH=/opt/ros/noetic/lib/python3/dist-packages
ENV LD_LIBRARY_PATH=/opt/ros/noetic/lib
ENV PATH=/opt/ros/noetic/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV ROS_ROOT=/opt/ros/noetic/share/ros
RUN git clone https://github.com/quetalasj/realsense_dataset
RUN cd realsense_dataset && sed -i 's#home/evgeny/PycharmProjects/realsense_dataset/#realsense_dataset/#g' record_bagfile.launch
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc
SHELL ["/bin/bash", "-c", "source /opt/ros/noetic/setup.bash &&"]

