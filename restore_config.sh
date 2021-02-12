#!/bin/bash

cd /opt/mesonet-ln-config
git pull
cora_cmd < /opt/mesonet-ln-config/network_config.cora
