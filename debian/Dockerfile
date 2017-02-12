FROM ubuntu:16.04

RUN apt-get update && apt-get install -y make \
  dpkg \
  git \
  wget

ENV goversion 1.7.5
ENV gofile go${goversion}.linux-amd64.tar.gz
ENV gourl https://storage.googleapis.com/golang/${gofile}

RUN wget -q -O /usr/local/${gofile} ${gourl} \
  && mkdir /usr/local/go \
  && tar -xzf /usr/local/${gofile} -C /usr/local/go --strip 1

CMD cd /mnt/build && PATH=/usr/local/go/bin:$PATH make deb
