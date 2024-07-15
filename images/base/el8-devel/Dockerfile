ARG IMAGE_PREFIX
FROM $IMAGE_PREFIX/base:el8

RUN dnf -q -y group install development --exclude=jna
RUN dnf -q -y group install rpm-development-tools
RUN dnf -q -y install gcc-gfortran
