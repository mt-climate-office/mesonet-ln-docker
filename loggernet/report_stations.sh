#!/bin/bash

trap 'rm -f "$TMPFILE"' EXIT

TMPFILE=$(mktemp) || exit 1
echo "Our temp file is $TMPFILE"

## Get a station's data
cora_cmd \
--echo=on \
--input="{
connect localhost; 
logger-query-ex $1 FiveMin $TMPFILE most-recent 1 --format=\"CSIXML\";
}"

cat $TMPFILE |\
xq . 
#curl --header "Content-Type: application/json" \
#  --request POST \
#  --data . \
#  https://mesonet.climate.umt.edu/api/loggernet
