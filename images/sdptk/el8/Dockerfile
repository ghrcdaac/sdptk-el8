ARG IMAGE_PREFIX
FROM $IMAGE_PREFIX/base:el8-devel


# hdf5 from epel8 requires libaec (szip replacement)
#  - rockylinux:8 "powertools" repo has libaec
#  - rockylinux:9 "crb" repo has libaec
RUN dnf -q -y install yum-utils
RUN yum-config-manager --enable powertools
RUN dnf -q -y install epel-release
RUN dnf makecache

# Required by hdfeos2
RUN dnf -q -y install libjpeg-turbo-devel
RUN dnf -q -y install hdf-devel

# Required by hdfeos5
RUN dnf -q -y install hdf5-devel

# Required by sdptk
RUN dnf -q -y install ksh tcsh


#
# hdfeos2
#
ADD ["hdf-eos2-3.0-src.tar.gz","/"]
WORKDIR /hdf-eos2-3.0/
RUN chown -R 0:0 .
RUN \
    ./configure \
        --prefix=/usr/local/sdptk/hdfeos2 \
        --disable-dependency-tracking \
        --enable-gctp-include \
    ;
RUN make
RUN make check
RUN make install
RUN install -v -t /usr/local/sdptk/hdfeos2/include include/ease.h
WORKDIR /
RUN rm -r /hdf-eos2-3.0/


#
# hdfeos5
#
ADD ["hdf-eos5-2.0-src.tar.gz","/"]
WORKDIR /hdf-eos5-2.0/
RUN chown -R 0:0 .
RUN \
    ./configure \
        --prefix=/usr/local/sdptk/hdfeos5 \
        --disable-dependency-tracking \
        --enable-gctp-include \
    ;
RUN make
RUN make check
RUN make install
WORKDIR /
RUN rm -r /hdf-eos5-2.0/


#
# sdptk
#
ADD ["SDPTK5.2.20v1.01.tar.Z","fixes-SDPTK5.2.20v1.01.patch","/"]
WORKDIR /usr/local/sdptk
RUN tar xf /SDPTK5.2.20v1.01.tar.Z && rm -v /SDPTK5.2.20v1.01.tar.Z
WORKDIR /usr/local/sdptk/TOOLKIT
RUN chown -R 0:0 .
RUN patch -p1 < /fixes-SDPTK5.2.20v1.01.patch && rm /fixes-SDPTK5.2.20v1.01.patch
RUN \
    ./configure \
        --disable-dependency-tracking \
        --with-hdf4=/usr/include/hdf,/usr/lib64 \
        --with-hdfeos2=/usr/local/sdptk/hdfeos2 \
        --with-hdfeos5=/usr/local/sdptk/hdfeos5 \
        CFLAGS="$(pkg-config --cflags libtirpc)" \
    ;:
RUN make
RUN make check
RUN make install
RUN make --keep-going distclean ||:

ENV PGSHOME=/usr/local/sdptk/TOOLKIT
ENV PGSBIN=$PGSHOME/bin/linux64
ENV PGSDAT=$PGSHOME/database/linux64
ENV PGSINC=$PGSHOME/include
ENV PGSMSG=$PGSHOME/message
ENV PGSLIB=$PGSHOME/lib/linux64
ENV PGSOBJ=$PGSHOME/obj/linux64
ENV PGSCPPO=$PGSHOME/objcpp/linux64
ENV PGSRUN=$PGSHOME/runtime
ENV PGSSRC=$PGSHOME/src
ENV PGSTST=$PGSHOME/test
ENV PGS_PC_INFO_FILE=$PGSRUN/PCF.relB
ENV PATH=$PATH:$PGSBIN
