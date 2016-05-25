FROM resin/rpi-raspbian
MAINTAINER Philpz <philipzheng@gmail.com>

ENV QEMU_EXECVE 1
COPY qemu/cross-build-end qemu/cross-build-start qemu/qemu-arm-static qemu/sh-shim /usr/bin/
RUN [ "cross-build-start" ]
ENV LC_ALL=C.UTF-8
RUN apt-get update -y && apt-get install -y python-pip python-dev wget vim bzip2 gcc gfortran libatlas-base-dev cython
RUN wget --no-check-certificate https://github.com/samjabrahams/tensorflow-on-raspberry-pi/raw/master/bin/tensorflow-0.8.0-cp27-none-linux_armv7l.whl && pip install tensorflow-0.8.0-cp27-none-linux_armv7l.whl && rm tensorflow-0.8.0-cp27-none-linux_armv7l.whl
RUN wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-armv7l.sh && \
    bash ./Miniconda-latest-Linux-armv7l.sh -b -p /usr/local/miniconda && \
    rm ./Miniconda-latest-Linux-armv7l.sh
ENV PATH /usr/local/miniconda/bin:$PATH
RUN conda install -y scikit-learn scipy 
RUN conda install -y -c cmckeague ipykernel matplotlib notebook nbformat jupyter_core && python -m ipykernel.kernelspec
RUN [ "cross-build-end" ]

COPY jupyter_notebook_config.py /root/.jupyter/
COPY notebooks /notebooks
COPY run_jupyter.sh /

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR "/notebooks"

CMD ["/run_jupyter.sh"]
