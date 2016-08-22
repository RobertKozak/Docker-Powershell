FROM ubuntu:xenial
MAINTAINER Robert Kozak "rkozak@nowcom.com"

ENV DEBIAN_FRONTEND noninteractive

COPY ./*.sh ./tmp/
RUN /bin/bash -c "source ./tmp/setup.sh" && \
    /bin/bash -c "source ./tmp/cleanup.sh" && \
    rm ./tmp/*

ENTRYPOINT ["powershell"]
