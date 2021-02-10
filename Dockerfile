FROM bitnami/minideb:buster
MAINTAINER Kyle Bocinsky, bocinsky@gmail.com

EXPOSE 6789

# install dependencies
RUN apt-get update && apt-get install -y \
      curl \
      libcurl4 \
      zip \
      xdg-utils \
      htop \
      net-tools \
      openssh-client \
      git


# RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d

# Download public key for github.com
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# Clone private repository
RUN --mount=type=ssh git clone git@github.com:mt-climate-office/loggernet.git /opt/loggernet

RUN dpkg --install /opt/loggernet/loggernet-debian_4.6-11_x86_64.deb

RUN ln -s /opt/CampbellSci/LoggerNet/cora_cmd /usr/local/bin/cora_cmd

ENTRYPOINT /etc/init.d/csilgrnet start && tail -f /dev/null

