
FROM        ubuntu:trusty
MAINTAINER  Robin Sommer <robin@icir.org>

# Setup environment.
ENV PATH /opt/llvm/bin:$PATH

# Default command on startup.
CMD bash

# Setup packages.
RUN apt-get update && apt-get -y install cmake git build-essential vim python wget libboost-all-dev libeigen3-dev curl libtool autoconf automake uuid-dev build-essential

# Copy install-clang over.
#ADD . /opt/install-clang

# Compile and install LLVM/clang. We delete the source directory to
# avoid committing it to the image.
#RUN /opt/install-clang/install-clang -C /opt/llvm

RUN /bin/sh -c 'cd ~ && \
                       wget http://download.zeromq.org/zeromq-4.0.5.tar.gz && \
                       tar zxvf zeromq-4.0.5.tar.gz && cd zeromq-4.0.5 && \
                       ./configure && make && make install && cd ~'

RUN /bin/sh -c "git clone https://github.com/zeromq/azmq.git /root/azmq && cd /root/azmq && mkdir build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local && make && make test && make install"

RUN /bin/sh -c 'git clone https://github.com/schuhschuh/cmake-basis.git -b develop /root/cmake-basis && cd /root/cmake-basis && mkdir build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local && make && make install'

RUN /bin/sh -c 'git clone https://github.com/google/flatbuffers.git /root/flatbuffers && cd /root/ && mkdir build-flatbuffers && cd build-flatbuffers && cmake ../flatbuffers -DCMAKE_INSTALL_PREFIX=/usr/local && make && make install'

RUN /bin/sh -c 'git clone https://github.com/ahundt/robone.git -b develop /root/robone/ && cd /root/robone && mkdir build && cd build '

RUN /bin/sh -c 'ls /root/robone/src/../include/robone/flatbuffer/ && cd /root/robone/build && cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DZMQ_ROOT=/root'
