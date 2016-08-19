FROM ubuntu:xenial
MAINTAINER Robert Kozak "rkozak@nowcom.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get -y install apt-transport-https wget libunwind8 libicu55 \
  && sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list' \
  && apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 \
  && apt-get update \
  && apt-get install dotnet-dev-1.0.0-preview2-003121 -y \
  && wget --quiet --output-document=powershell.deb https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-alpha.9/powershell_6.0.0-alpha.9-1ubuntu1.16.04.1_amd64.deb \
  && dpkg --install powershell.deb \
  && rm powershell.deb

ENTRYPOINT ["powershell"]
