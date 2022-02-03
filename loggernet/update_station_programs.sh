#!/bin/bash

cd /opt/mesonet-ln-stations

stations="`curl https://mesonet.climate.umt.edu/api/loggernet | jq -r '. | @sh' | tr -d \'`"

echo $stations

for station in $stations
do
    git switch -C $station
    
    cora_cmd \
        --echo=on \
        --input="{
            connect localhost;
            get-program-file ${station} --use-cache=true --file-name=$station.txt --file-path=/opt/mesonet-ln-stations/;
            }"
    
    [ -s \\$station.txt ] && mv \\$station.txt $station.txt || rm -f \\$station.txt
    
    git add .
    git commit -m "updated ${station} program backup"
    git push
    git switch main
done
