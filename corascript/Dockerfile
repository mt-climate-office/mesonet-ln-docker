# FROM bitnami/minideb:buster
FROM python:3-slim-bullseye
MAINTAINER Kyle Bocinsky, bocinsky@gmail.com

ENV SSH_KEY=""

EXPOSE 6789

# install dependencies
RUN apt-get update && apt-get install -y \
#      curl \
#      libcurl4 \
#      zip \
#      xdg-utils \
#      htop \
#      net-tools \
      openssh-client \
      git

## Set time zone for server
#ENV TZ=America/Denver
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Download public key for github.com
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# Clone private repositories
RUN --mount=type=ssh git clone git@github.com:mt-climate-office/mesonet-ln-software /opt/mesonet-ln-software

RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d

RUN dpkg --install /opt/mesonet-ln-software/loggernet-debian_4.7-12_x86_64.deb
