FROM ghcr.io/cpslab-asu/gzcm/base:22.04

LABEL org.opencontainers.image.source=https://github.com/cpslab-asu/gzcm
LABEL org.opencontainers.image.description="GZCM image with PX4 firmware"
LABEL org.opencontainers.image.license=BSD-3-Clause

RUN apt-get update && apt-get install -y git
ENV FIRMWARE_ROOT=/opt/ardupilot
RUN git clone --recurse-submodules https://github.com/ArduPilot/ardupilot.git ${FIRMWARE_ROOT}

WORKDIR ${FIRMWARE_ROOT}
RUN git checkout Copter-4.5.7
RUN apt-get update && apt-get install -y \
    build-essential \
    ccache \
    g++ \
    gawk \
    git \
    make \
    wget \
    valgrind \
    screen \
    python3 \
    python3-dev \
    python3-pexpect \
    python3-empy \
    python3-future \
    ;

RUN ./waf configure --board sitl
RUN ./waf copter
