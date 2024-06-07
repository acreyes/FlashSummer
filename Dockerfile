FROM ubuntu:22.04

ENV MPICH=4.1.2
ENV HDF5=1.12.0
ENV HYPRE=2.30.0

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
RUN apt-get update && apt-get -y install \
    bash \
    build-essential \
    cmake \
    less \
    g++-12 \
    gcc-12 \
    gfortran-12 \
    liblapack-dev \
    libz-dev \
    python2 \
    python3-pip \
    openssh-client \
    subversion \
    m4 \
    wget && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python2 /usr/local/bin/python


#########################
#                       #
#     INSTALL MPICH     #
#                       #
#########################
RUN wget -q -O - http://www.mpich.org/static/downloads/${MPICH}/mpich-${MPICH}.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/mpich-${MPICH} && \
    FC=gfortran-12 CC=gcc-12 CXX=g++-12 ./configure && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/mpich-${MPICH}


# ########################
# #                      #
# #     INSTALL HDF5     #
# #                      #
# ########################
RUN wget -q -O - https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-${HDF5}/src/hdf5-${HDF5}.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/hdf5-${HDF5} && \
    ./configure --prefix=/usr/local --enable-parallel --enable-fortran && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/hdf5-${HDF5}

# # #########################
# # #                       #
# # #     INSTALL HYPRE     #
# # #                       #
# # #########################
RUN wget -q -O - https://github.com/hypre-space/hypre/archive/v${HYPRE}.tar.gz | tar -C /tmp -xzf - && \
    cd /tmp/hypre-${HYPRE}/src && \
    ./configure --prefix=/usr/local CFLAGS=-fPIC && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/hypre-${HYPRE}

# PYBIND11 YT H5PY
ENV HDF5_DIR=/usr/local
RUN pip3 install --upgrade pip
RUN pip3 install pybind11 yt h5py

RUN useradd -m -G sudo -s /bin/bash \
    -p $(perl -e 'print crypt($ARGV[0], "password")' 'flash') flash


USER flash

WORKDIR /home/flash

ENTRYPOINT ["/bin/bash"]

