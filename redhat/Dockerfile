FROM centos:7
ARG goversion

RUN yum -y update \
    && yum -y install \
    make \
    git \
    rpm-build \
    wget \
    && yum clean all

ENV gofile go${goversion}.linux-amd64.tar.gz
ENV gourl https://storage.googleapis.com/golang/${gofile}

RUN wget -q -O /usr/local/${gofile} ${gourl} \
  && mkdir /usr/local/go \
  && tar -xzf /usr/local/${gofile} -C /usr/local/go --strip 1

CMD cd /mnt/build && PATH=/usr/local/go/bin:$PATH make rpm
