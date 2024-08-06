#!/bin/sh
set -e -x -v

echo "Downloading ln software"
# Clone private repositories
RUN GIT_SSH_COMMAND='ssh -i /run/secrets/SSH_KEY' git clone git@github.com:mt-climate-office/mesonet-ln-software /opt/mesonet-ln-software
RUN GIT_SSH_COMMAND='ssh -i /run/secrets/SSH_KEY' git clone git@github.com:mt-climate-office/mesonet-ln-server /opt/mesonet-ln-server
RUN GIT_SSH_COMMAND='ssh -i /run/secrets/SSH_KEY' git clone git@github.com:mt-climate-office/mesonet-ln-programs /opt/mesonet-ln-programs

RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d

echo "Installing LoggerNet"
RUN dpkg --install /opt/mesonet-ln-software/loggernet-debian_4.7-12_x86_64.deb

RUN ln -s /opt/CampbellSci/LoggerNet/cora_cmd /usr/local/bin/cora_cmd
RUN chmod u+x /opt/*.sh

ENV SSH_KEY=$(cat /run/secrets/SSH_KEY)

# Verify our environment variables are set
[ -z "${SSH_KEY}" ] && { echo "Need to set SSH_KEY"; exit 1; }

# Set up our SSH Key
echo "Configuring SSH Key"

echo "${SSH_KEY}" > ~/.ssh/id_rsa
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa

# Configure our user and email to commit as.
echo "Configuring git"
git config --global user.name "Git Service"
git config --global user.email git@example.com

echo "Starting LoggerNet Service"
/etc/init.d/csilgrnet start

## restore initial configuration
cd /opt/mesonet-ln-server
git pull
#bash /opt/restore_config.sh

sleep 30

env >> ~/env.log
echo 'PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' > /etc/crontab
echo 'SHELL=/bin/bash' >> /etc/crontab
echo '0 * * * * root bash -c "source $HOME/env.log; source /opt/backup_config.sh"' >> /etc/crontab # every hour, check for server config updates
echo '*/5 * * * * root bash -c "source $HOME/env.log; source /opt/update_stations.sh"' >> /etc/crontab # Every 5 minutes, check for new data
echo '*/15 * * * * root bash -c "source $HOME/env.log; source /opt/update_station_programs.sh"' >> /etc/crontab # Every 15 minutes, check for program updates

echo "Host *\n    StrictHostKeyChecking no\n    UserKnownHostsFile=/dev/null\n" > ~/.ssh/config

# start cron
service cron start
service rsyslog start

tail -f /dev/null
