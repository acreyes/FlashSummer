FROM ubuntu:20.04

##########################
#                        #
#     INSTALL TZDATA     #
#                        #
##########################
RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata


#############################
#                           #
#     INSTALL COMPILERS     #
#                           #
#############################
RUN apt-get -y install \
    bash \
    build-essential \
    g++ \
    gcc \
    gdb \
    gfortran \
    liblapack-dev \
    libz-dev \
    openssh-client \
    subversion \
    python3 \
    pip \
    git \
    sudo \
    wget \
    && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3 /usr/local/bin/python


#########################
#                       #
#     INSTALL MPICH     #
#                       #
#########################
RUN wget -q -O - http://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/mpich-3.3.2 && \
    ./configure && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/mpich-3.3.2


########################
#                      #
#     INSTALL HDF5     #
#                      #
########################
RUN wget -q -O - https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.0/src/hdf5-1.12.0.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/hdf5-1.12.0 && \
    ./configure --prefix=/usr/local --enable-parallel --enable-fortran && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/hdf5-1.12.0


#########################
#                       #
#     INSTALL HYPRE     #
#                       #
#########################
RUN wget -q -O - https://github.com/hypre-space/hypre/archive/v2.19.0.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/hypre-2.19.0/src && \
    ./configure --prefix=/usr/local && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/hypre-2.19.0

# ##########################
# #                        #
# #      INSTALL YT     #
# #                        #
# ##########################
RUN pip3 install yt h5py


RUN useradd -m -G sudo -s /bin/bash \
    -p $(perl -e 'print crypt($ARGV[0], "password")' 'flash') flash


USER flash

WORKDIR /home/flash

ENTRYPOINT ["/bin/bash"]

