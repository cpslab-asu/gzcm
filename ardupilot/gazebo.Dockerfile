ARG GZ_VERSION=harmonic
FROM ghcr.io/cpslab-asu/gzcm/gazebo:${GZ_VERSION}

LABEL org.opencontainers.image.source=https://github.com/cpslab-asu/gzcm
LABEL org.opencontainers.image.description="GZCM gazebo image with Ardupilot plugin, models, and worlds"
LABEL org.opencontainers.image.license=BSD-3-Clause

RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y \
    git \
    rapidjson-dev \
    libgz-sim8-dev \
    libopencv-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-libav \
    gstreamer1.0-gl \
    ;

ENV PLUGIN_ROOT=/opt/ardupilot_gazebo
RUN git clone https://github.com/ArduPilot/ardupilot_gazebo ${PLUGIN_ROOT}
RUN GZ_VERSION=${GZ_VERSION} cmake -S ${PLUGIN_ROOT} -B ${PLUGIN_ROOT}/build -D CMAKE_BUILD_TYPE=RelWithDebInfo
RUN cmake --build ${PLUGIN_ROOT}/build

ENV GZ_SIM_SYSTEM_PLUGIN_PATH=${PLUGIN_ROOT}/build
ENV GZ_SIM_RESOURCE_PATH=${PLUGIN_ROOT}/models:${PLUGIN_ROOT}/worlds
