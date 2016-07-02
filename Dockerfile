FROM centos:7

RUN yum -y update \
    && yum -y install \
    make \
    rpm-build \
    wget \
    && yum clean all

CMD cd /mnt/build && make package
