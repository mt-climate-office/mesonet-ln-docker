#!/bin/bash

cd /opt/mesonet-ln-server
git pull
cora_cmd < /opt/mesonet-ln-server/network_config.cora
