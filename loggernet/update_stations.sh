#!/bin/bash

stations="`curl https://mesonet.climate.umt.edu/api/v2/loggernet/ | jq -r '. | @sh' | tr -d \'`"

echo $stations

for station in $stations
do
	/opt/report_station.sh $station
done
