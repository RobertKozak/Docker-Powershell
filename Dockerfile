FROM ubuntu:xenial
MAINTAINER Robert Kozak "rkozak@nowcom.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&& apt-get -y install wget libunwind8 libicu55 \

&& wget --quiet --output-document=powershell.deb https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-alpha.9/powershell_6.0.0-alpha.9-1ubuntu1.16.04.1_amd64.deb \
&& dpkg --install powershell.deb \
&& rm powershell.deb

ENTRYPOINT ["powershell"]
