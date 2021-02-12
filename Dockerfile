FROM bitnami/minideb:buster
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
      cron


# Download public key for github.com
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# Clone private repositories
RUN --mount=type=ssh git clone git@github.com:mt-climate-office/mesonet-ln-software /opt/mesonet-ln-software
RUN --mount=type=ssh git clone git@github.com:mt-climate-office/mesonet-ln-config /opt/mesonet-ln-config

RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d

RUN dpkg --install /opt/mesonet-ln-software/loggernet-debian_4.6-11_x86_64.deb

RUN ln -s /opt/CampbellSci/LoggerNet/cora_cmd /usr/local/bin/cora_cmd

COPY entrypoint.sh /entrypoint.sh
COPY backup_config.sh /opt/backup_config.sh
COPY backup_config.cora /opt/backup_config.cora
COPY restore_config.sh /opt/restore_config.sh

# Automated minutely backups of configuration
RUN printf '* * * * * bash /opt/backup_config.sh\n' > /opt/backup_config
# Give execution rights on the cron job
RUN chmod 0644 /opt/backup_config
# Apply cron job
RUN crontab /opt/backup_config

ENTRYPOINT ["/entrypoint.sh"]
