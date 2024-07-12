ARG IMAGE_PREFIX
FROM $IMAGE_PREFIX/base:el8-devel


RUN dnf -q -y install yum-utils
RUN yum-config-manager --enable powertools
RUN dnf -q -y install epel-release
RUN dnf makecache

RUN dnf -q -y install libjpeg-turbo-devel
RUN dnf -q -y install hdf-devel
RUN dnf -q -y install hdf5-devel


# ADD ["hdf-eos2-3.0-src.tar.gz","/"]
# WORKDIR /hdf-eos2-3.0/
# RUN chown -R 0:0 .
# RUN \
#     ./configure \
#         --prefix=/dummy/hdfeos2 \
#         --libdir=/dummy/hdfeos2/lib64 \
#         --disable-dependency-tracking \
#         --enable-install-include \
#         --enable-gctp-include \
#     ;
# ############################################################################
# # Installation directories:
# #   --exec-prefix=EPREFIX   install architecture-dependent files in EPREFIX
# #                           [PREFIX]

# # Fine tuning of the installation directories:
# #   --bindir=DIR            user executables [EPREFIX/bin]
# #   --sbindir=DIR           system admin executables [EPREFIX/sbin]
# #   --libexecdir=DIR        program executables [EPREFIX/libexec]
# #   --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
# #   --sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
# #   --localstatedir=DIR     modifiable single-machine data [PREFIX/var]
# #   --includedir=DIR        C header files [PREFIX/include]
# #   --oldincludedir=DIR     C header files for non-gcc [/usr/include]
# #   --datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
# #   --datadir=DIR           read-only architecture-independent data [DATAROOTDIR]
# #   --infodir=DIR           info documentation [DATAROOTDIR/info]
# #   --localedir=DIR         locale-dependent data [DATAROOTDIR/locale]
# #   --mandir=DIR            man documentation [DATAROOTDIR/man]
# #   --docdir=DIR            documentation root [DATAROOTDIR/doc/hdf-eos2]
# #   --htmldir=DIR           html documentation [DOCDIR]
# #   --dvidir=DIR            dvi documentation [DOCDIR]
# #   --pdfdir=DIR            pdf documentation [DOCDIR]
# #   --psdir=DIR             ps documentation [DOCDIR]

# # Program names:
# #   --program-prefix=PREFIX            prepend PREFIX to installed program names
# #   --program-suffix=SUFFIX            append SUFFIX to installed program names
# #   --program-transform-name=PROGRAM   run sed PROGRAM on installed program names

# # Optional Features:
# #   --disable-option-checking  ignore unrecognized --enable/--with options
# #   --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
# #   --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
# #   --enable-silent-rules   less verbose build output (undo: "make V=1")
# #   --disable-silent-rules  verbose build output (undo: "make V=0")
# #   --enable-shared[=PKGS]  build shared libraries [default=no]
# #   --enable-static[=PKGS]  build static libraries [default=yes]
# #   --enable-fast-install[=PKGS]
# #                           optimize for fast installation [default=yes]
# #   --disable-libtool-lock  avoid locking (might break parallel builds)
# #   --enable-fortran        Enable fortran components/tests

# # Optional Packages:
# #   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
# #   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
# #   --with-pic[=PKGS]       try to use only PIC/non-PIC objects [default=use
# #                           both]
# #   --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
# #   --with-sysroot=DIR Search for dependent libraries within DIR
# #                         (or the compiler's sysroot if not specified).
# #   --with-jpeg=DIR         Specify path to external jpeg library. Linker must
# #                           be able to find jpeg if HDF4 was built with jpeg.
# #                           [default=yes]
# #   --with-zlib=DIR         Specify path to external zlib library. Linker must
# #                           be able to find zlib if HDF4 was built with zlib.
# #                           [default=yes]
# #   --with-szlib=DIR        Use szlib library for external szlib I/O filter.
# #                           Linker must be able to find szlib if HDF4 was build
# #                           with szip.
# #   --with-hdf4=DIR         Specify path to HDF4 library to use while building
# #                           [default=yes]

# # Some influential environment variables:
# #   CC          C compiler command
# #   CFLAGS      C compiler flags
# #   LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
# #               nonstandard directory <lib dir>
# #   LIBS        libraries to pass to the linker, e.g. -l<library>
# #   CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
# #               you have headers in a nonstandard directory <include dir>
# #   CPP         C preprocessor
# #   F77         Fortran 77 compiler command
# #   FFLAGS      Fortran 77 compiler flags

# # Use these variables to override the choices made by `configure' or to help
# # it to find libraries and programs with nonstandard names/locations.
# ############################################################################
# RUN make
# RUN make check
# RUN make install
# # WORKDIR /
# # RUN rm -r /hdf-eos2-3.0/


ADD ["SDPTK5.2.20v1.01.tar.Z","fixes-SDPTK5.2.20v1.01.patch","/"]
WORKDIR /
RUN tar xf /SDPTK5.2.20v1.01.tar.Z && rm -v /SDPTK5.2.20v1.01.tar.Z
WORKDIR /TOOLKIT
RUN patch -p1 < /fixes-SDPTK5.2.20v1.01.patch && rm /fixes-SDPTK5.2.20v1.01.patch
RUN \
    ./configure \
        --prefix=/dummy/sdptk \
        --libdir=/dummy/sdptk/lib64 \
        --disable-dependency-tracking \
        --with-hdf4=/usr/include/hdf,/usr/lib64 \
        --with-hdfeos2=/dummy/hdfeos2/include,/dummy/hdfeos2/lib64 \
    ;:
############################################################################
# Installation directories:
#     --exec-prefix=EPREFIX   install architecture-dependent files in EPREFIX
#                             [PREFIX]
#     --bindir=DIR           user executables [EPREFIX/bin]
#     --sbindir=DIR          system admin executables [EPREFIX/sbin]
#     --libexecdir=DIR       program executables [EPREFIX/libexec]
#     --datadir=DIR          read-only architecture-independent data [PREFIX/share]
#     --sysconfdir=DIR       read-only single-machine data [PREFIX/etc]
#     --sharedstatedir=DIR   modifiable architecture-independent data [PREFIX/com]
#     --localstatedir=DIR    modifiable single-machine data [PREFIX/var]
#     --includedir=DIR       C header files [PREFIX/include]
#     --oldincludedir=DIR    C header files for non-gcc [/usr/include]
#     --infodir=DIR          info documentation [PREFIX/info]
#     --mandir=DIR           man documentation [PREFIX/man]
  
#   Program names:
#     --program-prefix=PREFIX            prepend PREFIX to installed program names
#     --program-suffix=SUFFIX            append SUFFIX to installed program names
#     --program-transform-name=PROGRAM   run sed PROGRAM on installed program names
  
#   Optional Features:
#     --enable-fortran        Build Fortran into library [default=no]
#     --enable-shared[=PKGS]
#                             build shared libraries [default=no]
#     --enable-static[=PKGS]
#                             build static libraries [default=yes]
#     --enable-fast-install[=PKGS]
#                             optimize for fast installation [default=yes]
#     --disable-libtool-lock  avoid locking (might break parallel builds)
  
#   Optional Packages:
#     --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
#     --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
#     --with-aa               Flag to build AA libraries. AA files need their own
#                             seperate packages and some users may not want to
#                             include the AA tools with the SDP Toolkit.
#                             Otherwise, this flag can be set.
#     --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
#     --with-pic              try to use only PIC/non-PIC objects [default=use
#                             both]
#     --with-tags[=TAGS]
#                             include additional configurations [automatic]
  
#    For the following --with-xxx options, you can specify where the header
#    files and libraries are in two different ways:
  
#       --with-xxx=INC,LIB - Specify individually the include directory and
#                            library directory separated by a comma
#       --with-xxx=DIR     - Specify only the directory which contains the
#                            include/ and lib/ subdirectories
  
#     --with-zlib=DIR         Use zlib library [default=yes]
#     --with-jpeg=DIR         Use jpeg library [default=yes]
#     --with-szlib=DIR        Use szlib library [default=no]
#     --with-hdf5=DIR         Where to find the HDF5 library
#     --with-hdfeos5=DIR      Where to find the HDFEOS5 library
#     --with-x                use the X Window System
  
#   Some influential environment variables:
#     CC          C compiler command
#     CFLAGS      C compiler flags
#     LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
#                 nonstandard directory <lib dir>
#     CPPFLAGS    C/C++ preprocessor flags, e.g. -I<include dir> if you have
#                 headers in a nonstandard directory <include dir>
#     CXX         C++ compiler command
#     CXXFLAGS    C++ compiler flags
#     FC          Fortran compiler command
#     FCFLAGS     Fortran compiler flags
#     CPP         C preprocessor
#     CXXCPP      C++ preprocessor
#     F77         Fortran 77 compiler command
#     FFLAGS      Fortran 77 compiler flags
############################################################################

# WORKDIR /
# RUN rm -rf /TOOLKIT
