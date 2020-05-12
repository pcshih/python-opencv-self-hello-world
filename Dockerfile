# base image
FROM ubuntu:18.04

# to handle tzdata select zone problem
ENV DEBIAN_FRONTEND="noninteractive"

# user infomation
ARG GID
ARG USER_NAME
ARG UID

WORKDIR /root

# to install some package(setup environment)
RUN \
groupadd -g ${GID} ${USER_NAME} && \
useradd --create-home --uid ${UID} --gid ${GID} --shell /bin/bash ${USER_NAME} && \
apt-get update -y && \
apt-get install -y zsh wget unzip git nano && \
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | zsh || true && \
apt-get install -y software-properties-common && \
add-apt-repository ppa:deadsnakes/ppa && \
add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
apt-get update -y && \  
apt-get install -y python3.6 python3.6-dev python3-pip python3-numpy tzdata && \
ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
dpkg-reconfigure -f noninteractive tzdata && \
pip3 install --upgrade pip && \
wget -O opencv-4.3.0.zip https://github.com/opencv/opencv/archive/4.3.0.zip && \
unzip opencv-4.3.0.zip && \
wget -O opencv_contrib-4.3.0.zip https://github.com/opencv/opencv_contrib/archive/4.3.0.zip && \
unzip opencv_contrib-4.3.0.zip && \
apt-get install -y build-essential && \
apt-get install -y cmake libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev && \
apt-get install -y libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev && \
cd opencv-4.3.0 && mkdir build && cd build && \
cmake -DCMAKE_BUILD_TYPE=Release \
-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.3.0/modules/ \
-DOPENCV_ENABLE_NONFREE=ON \
-DPYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
-DCMAKE_INSTALL_PREFIX=/usr/local .. && \
make -j20 && make install && \
mv /usr/local/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so /usr/local/lib/python3.6/dist-packages && \
rm -r /usr/local/lib/python3.6/dist-packages/cv2