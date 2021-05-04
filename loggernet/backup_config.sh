#!/bin/bash

cd /opt/mesonet-ln-config

git pull

cora_cmd < /opt/backup_config.cora

git add .
git commit -m "created network backup"
git push
