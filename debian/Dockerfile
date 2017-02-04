FROM ubuntu:16.04

RUN apt-get update && apt-get install -y make \
  dpkg \
  git \
  wget

CMD cd /mnt/build && make deb
