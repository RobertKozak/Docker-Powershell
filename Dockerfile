FROM ubuntu:xenial
MAINTAINER Robert Kozak "rkozak@nowcom.com"

ENV DEBIAN_FRONTEND noninteractive

COPY ./*.sh .
RUN /bin/bash -c "source ./setup.sh" \
    && /bin/bash -c "source ./cleanup.sh" \
    && rm ./*.sh

ENTRYPOINT ["powershell"]
