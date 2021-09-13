# FROM bitnami/minideb:buster
FROM python:3-slim-buster
MAINTAINER Kyle Bocinsky, bocinsky@gmail.com

ENV SSH_KEY=""

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
      git \
      cron \
      vim \
      rsyslog \
      jq

RUN pip install yq

# Download public key for github.com
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# Clone private repositories
RUN --mount=type=ssh git clone git@github.com:mt-climate-office/mesonet-ln-software /opt/mesonet-ln-software
RUN --mount=type=ssh git clone git@github.com:mt-climate-office/mesonet-ln-config /opt/mesonet-ln-config
RUN --mount=type=ssh git clone git@github.com:mt-climate-office/mesonet-ln-config /opt/mesonet-csi-config

RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d

RUN dpkg --install /opt/mesonet-ln-software/loggernet-debian_4.7-12_x86_64.deb

RUN ln -s /opt/CampbellSci/LoggerNet/cora_cmd /usr/local/bin/cora_cmd

COPY entrypoint.sh /entrypoint.sh
COPY backup_config.sh /opt/backup_config.sh
COPY report_station.sh /opt/report_station.sh
RUN chmod u+x /opt/report_station.sh
COPY update_stations.sh /opt/update_stations.sh
RUN chmod u+x /opt/update_stations.sh
# COPY backup_config.cora /opt/backup_config.cora
COPY restore_config.sh /opt/restore_config.sh
COPY update_station_programs.sh /opt/update_station_programs.sh
RUN chmod u+x /opt/update_station_programs.sh

# Multipath fix for docker VM
RUN echo '\
defaults {\n\
    user_friendly_names yes\n\
}\n\
blacklist {\n\
    devnode "^(ram|raw|loop|fd|md|dm-|sr|scd|st)[0-9]*"\n\
    devnode "^sd[a-z]?[0-9]*"\n\
}' | tee /etc/multipath.conf

ENTRYPOINT ["/entrypoint.sh"]
