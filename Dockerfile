
FROM ubuntu
FROM ros:noetic

RUN  apt-get update && apt-get install -y udev 
RUN  apt-get install -y python3 python3-pip && pip install pyudev && pip install click
RUN apt-get install -y nodejs && apt-get install -y npm
RUN  apt install -y nano
WORKDIR /app
COPY package.json /app
COPY . /app
RUN apt install -y net-tools
RUN  apt-get install -y build-essential
RUN mkdir -p /home/catkin_ws/src
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; catkin_init_workspace /home/catkin_ws/src'

WORKDIR /home/catkin_ws
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; cd /home/catkin_ws; catkin_make'
RUN echo "source /home/catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN  apt-get install -y ros-noetic-web-video-server
WORKDIR /home/catkin_ws/src
RUN apt-get install -y git
RUN git clone https://github.com/Akrinvo/medicin_despenser.git
RUN git clone https://github.com/Akrinvo/pantilt.git
WORKDIR /home/catkin_ws
RUN pip install pyserial
RUN apt-get install -y python3-rospy
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; cd /home/catkin_ws; catkin_make'
# RUN echo "roslaunch pantilt medicin.launch" >> ~/.bashrc
WORKDIR /app

CMD npm start;node host_doctor_page.js