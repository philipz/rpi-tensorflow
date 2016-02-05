FROM philipz/rpi-debian-python
MAINTAINER Philpz <philipzheng@gmail.com>

ENV QEMU_EXECVE 1
COPY qemu/cross-build-end qemu/cross-build-start qemu/qemu-arm-static qemu/sh-shim /usr/bin/
RUN [ "cross-build-start" ]
ADD tensorflow-0.5.0-cp27-none-linux_armv7l.whl /
RUN apt-get update && apt-get -y upgrade && apt-get install build-essential python-dev
RUN pip install tensorflow-0.5.0-cp27-none-linux_armv7l.whl
RUN [ "cross-build-end" ]
