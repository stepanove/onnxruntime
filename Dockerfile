# --------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.
# --------------------------------------------------------------
# Dockerfile to run ONNXRuntime with source build for CPU

FROM arm64v8/ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
    	sudo \
    	build-essential \
    	git \
	libopenblas-dev \
        libpython3-dev \
        python3-pip \
        python3-dev \
	wget \
        zip \
        ca-certificates \
        curl \
        libcurl4-openssl-dev \
        libssl-dev

RUN pip3 install --upgrade pip 
RUN pip3 install --upgrade setuptools wheel
RUN pip3 install --upgrade numpy cmake

WORKDIR /workspace
RUN git clone --single-branch --branch master --recursive https://github.com/Microsoft/onnxruntime onnxruntime

WORKDIR /workspace/onnxruntime
RUN ./build.sh \
--skip_submodule_sync \
--config Release \
--update \
--build \
--build_wheel \
--parallel \
--cmake_extra_defines ONNXRUNTIME_VERSION=$(cat ./VERSION_NUMBER)

# --skip_submodule_sync \
#--use_openmp \
#--enable_pybind
#--build_shared_lib \

RUN ls -l /workspace/onnxruntime/build/Linux/Release/dist/*.whl

