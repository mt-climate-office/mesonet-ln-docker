#!/bin/bash

stations="`curl https://mesonet.climate.umt.edu/api/v2/loggernet/ | jq -r '. | @sh' | tr -d \'`"

echo $stations

n = 4


for station in $stations
do
    ((i=i%N)); ((i++==0)) && wait
    timeout 5m /opt/update_station.sh $station &
done
