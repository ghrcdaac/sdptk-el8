ARG IMAGE_PREFIX
FROM $IMAGE_PREFIX/base:el8-devel


# Installation directories
ARG HE2INSTALL=/usr/local/hdfeos2
ARG HE5INSTALL=/usr/local/hdfeos5
ARG PGSINSTALL=/usr/local/TOOLKIT


# hdf5 from epel8 requires libaec (szip replacement)
#  - rockylinux:8 "powertools" repo has libaec
#  - rockylinux:9 "crb" repo has libaec
RUN dnf -q -y install yum-utils
RUN yum-config-manager --enable powertools
RUN dnf -q -y install epel-release
RUN dnf makecache

# Include static dependencies
RUN dnf -q -y install glibc-static libstdc++-static zlib-static

# Required by hdfeos2
RUN dnf -q -y install libjpeg-turbo-devel
RUN dnf -q -y install hdf-devel hdf-static

# Required by hdfeos5
RUN dnf -q -y install hdf5-devel hdf5-static

# Required by sdptk
RUN dnf -q -y install ksh tcsh


# hdf4 compiler settings
# RUN echo '#include <df.h>' > dummy.c && h4cc -show dummy.c && rm dummy.c
ENV HDF4CFLAGS="-I/usr/include/hdf -DBIG_LONGS -DSWAP -I/usr/include/tirpc"
ENV HDF4LDFLAGS="-L/usr/lib64 -lmfhdf -ldf -ljpeg -lz -ltirpc"
# Validate hdf4 environment variables
RUN echo -e '#include <df.h>\nint main(){HDFopen(0,0,0);}' > /tmp/dummy.c
RUN set -x; gcc $HDF4CFLAGS -o /tmp/dummy.o -c /tmp/dummy.c
RUN set -x; gcc -o /tmp/dummy.exe /tmp/dummy.o $HDF4LDFLAGS
# RUN ldd /tmp/dummy.exe
RUN rm /tmp/dummy.*


# hdf5 compiler settings
# RUN echo '#include <hdf5.h>' > dummy.c && h5cc -show dummy.c && rm dummy.c
ENV HDF5CFLAGS="-I/usr/include"
ENV HDF5LDFLAGS="-L/usr/lib64 -lhdf5_hl -lhdf5 -lsz -lz -ldl -lm"
# Validate hdf4 environment variables
RUN echo -e '#include <hdf5.h>\nint main(){H5open();}' > /tmp/dummy.c
RUN set -x; gcc $HDF5CFLAGS -o /tmp/dummy.o -c /tmp/dummy.c
RUN set -x; gcc -o /tmp/dummy.exe /tmp/dummy.o $HDF5LDFLAGS
# RUN ldd /tmp/dummy.exe
RUN rm /tmp/dummy.*


#
# hdfeos2
#
ADD ["hdf-eos2-3.0-src.tar.gz","/"]
WORKDIR /hdf-eos2-3.0/
RUN chown -R 0:0 .
RUN \
    ./configure \
        --prefix=${HE2INSTALL} \
        --disable-dependency-tracking \
        --enable-gctp-include \
        --disable-shared \
        --enable-static \
    ;
RUN make
RUN make check
RUN make install
# Needed to satisfy SDPTK configure check for hdfeos2
RUN install -v -t ${HE2INSTALL}/include include/ease.h
# Headers and libraries
ENV HDFEOS2INC=$HE2INSTALL/include
ENV HDFEOS2LIB=$HE2INSTALL/lib
# Ensure hdfeos2 shared libraries can be found
# RUN echo "$HDFEOS2LIB" > /etc/ld.so.conf.d/hdfeos2.conf && ldconfig
# Compiler settings
# RUN sed -n -e '/ Configuration Summary/,/^$/p' config.log
ENV HDFEOS2CFLAGS="$HDF4CFLAGS -I$HDFEOS2INC"
ENV HDFEOS2LDFLAGS="-L$HDFEOS2LIB -lhdfeos -lGctp -lm $HDF4LDFLAGS"
# Validate hdfeos2 environment variables
WORKDIR /hdf-eos2-3.0/samples
# RUN env | sort
RUN set -x; gcc $HDFEOS2CFLAGS -c -o InquireGrid.o InquireGrid.c
RUN set -x; gcc -o InquireGrid InquireGrid.o $HDFEOS2LDFLAGS
# RUN ldd InquireGrid
# RUN ./InquireGrid
# Cleanup
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
        --prefix=${HE5INSTALL} \
        --disable-dependency-tracking \
        --enable-gctp-include \
        --disable-shared \
        --enable-static \
    ;
RUN make
RUN make check
RUN make install
# Headers and libraries
ENV HDFEOS5INC=$HE5INSTALL/include
ENV HDFEOS5LIB=$HE5INSTALL/lib
# Ensure hdfeos5 shared libraries can be found
# RUN echo "$HDFEOS5LIB" > /etc/ld.so.conf.d/hdfeos5.conf && ldconfig
# Compiler settings
# RUN sed -n -e '/ Configuration Summary/,/^$/p' config.log
ENV HDFEOS5CFLAGS="$HDF5CFLAGS -I$HDFEOS5INC"
ENV HDFEOS5LDFLAGS="-L$HDFEOS5LIB -lhe5_hdfeos -lGctp $HDF5LDFLAGS"
# Validate hdfeos5 environment variables
WORKDIR /hdf-eos5-2.0/samples
# RUN env | sort
RUN set -x; gcc $HDFEOS5CFLAGS -c -o he5_gd_info.o he5_gd_info.c
RUN set -x; gcc -o he5_gd_info he5_gd_info.o $HDFEOS5LDFLAGS
# RUN ldd he5_gd_info
RUN ./he5_gd_info
# Cleanup
WORKDIR /
RUN rm -r /hdf-eos5-2.0/


#
# sdptk
#
ADD ["SDPTK5.2.20v1.01.tar.Z","fixes-SDPTK5.2.20v1.01.patch","/"]
RUN mkdir -pv -- ${PGSINSTALL}
WORKDIR ${PGSINSTALL}
RUN tar xf /SDPTK5.2.20v1.01.tar.Z --strip-components=1 && rm -v /SDPTK5.2.20v1.01.tar.Z
RUN chown -R 0:0 .
RUN patch -p1 < /fixes-SDPTK5.2.20v1.01.patch && rm /fixes-SDPTK5.2.20v1.01.patch
RUN \
    ./configure \
        --disable-dependency-tracking \
        --disable-shared \
        --enable-static \
        --with-hdf4=/usr/include/hdf,/usr/lib64 \
        --with-hdfeos2=${HE2INSTALL} \
        --with-hdfeos5=${HE5INSTALL} \
        CFLAGS="$HDFEOS2CFLAGS $HDFEOS5CFLAGS" \
        LDFLAGS="$HDFEOS2LDFLAGS $HDFEOS5LDFLAGS" \
    ;:
RUN make
RUN make check
RUN make install
RUN make --keep-going distclean ||:
ENV PGSHOME=${PGSINSTALL}
ENV PGSBIN=$PGSINSTALL/bin/linux64
ENV PGSDAT=$PGSINSTALL/database/linux64
ENV PGSINC=$PGSINSTALL/include
ENV PGSMSG=$PGSINSTALL/message
ENV PGSLIB=$PGSINSTALL/lib/linux64
ENV PGSOBJ=$PGSINSTALL/obj/linux64
ENV PGSCPPO=$PGSINSTALL/objcpp/linux64
ENV PGSRUN=$PGSINSTALL/runtime
ENV PGSSRC=$PGSINSTALL/src
ENV PGSTST=$PGSINSTALL/test
ENV PGS_PC_INFO_FILE=$PGSRUN/PCF.relB
ENV PATH=$PATH:$PGSBIN
WORKDIR /
