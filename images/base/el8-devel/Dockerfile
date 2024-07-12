ARG IMAGE_PREFIX
FROM $IMAGE_PREFIX/base:el8

RUN dnf -q -y groupinstall development
RUN dnf -q -y groupinstall rpm-development-tools
RUN dnf -q -y install gcc-gfortran
