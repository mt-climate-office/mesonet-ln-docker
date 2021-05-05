#!/bin/sh
set -e -x -v

# Verify our environment variables are set
[ -z "${SSH_KEY}" ] && { echo "Need to set SSH_KEY"; exit 1; }

# Set up our SSH Key
echo "Configuring SSH Key"

echo "${SSH_KEY}" > ~/.ssh/id_rsa
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa

echo "Host *\n    StrictHostKeyChecking no\n    UserKnownHostsFile=/dev/null\n" > ~/.ssh/config

# Configure our user and email to commit as.
echo "Configuring git"
git config --global user.name "Git Service"
git config --global user.email git@example.com

echo "Starting LoggerNet Service"
/etc/init.d/csilgrnet start

# restore initial configuration
cd /opt/mesonet-ln-config
git pull
bash /opt/restore_config.sh

# start cron
service cron start
service rsyslog start

tail -f /dev/null
