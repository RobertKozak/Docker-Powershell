FROM ubuntu:xenial

MAINTAINER Robert Kozak "rkozak@nowcom.com"


ENV DEBIAN_FRONTEND noninteractive

COPY ./setup.sh .
RUN /bin/bash -c "source ./setup.sh" && rm ./setup.sh

ENTRYPOINT ["powershell"]
