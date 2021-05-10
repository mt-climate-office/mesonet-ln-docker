#!/bin/bash

cd /opt/mesonet-ln-config

git pull

#cora_cmd < /opt/backup_config.cora
cora_cmd \
--echo=off \
--input='{
connect localhost;
create-backup-script /opt/mesonet-ln-config/network_config.cora;
}'

git add .
git commit -m "created network backup"
git push
