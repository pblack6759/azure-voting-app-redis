#!/bin/bash

count=0
started='false'
#echo "started: $started"
while [[ $started == 'false' ]]
do
    ((count++))
    echo "[$STAGE_NAME] Starting container [Attempt: $count]"

    testStart=$(curl --write-out '%{http_code}' --silent --output /dev/null "http://172.18.0.2:8000")
    #echo "test start = $testStart"
    if [[ testStart -eq '200' ]]
    then
        started='true'
        echo "The container has started"
    else
        if [[ count -eq 3 ]]
        then
                break;
        else
                sleep 1
        fi
    fi
done
if [[ started == 'false' ]]
then
    echo "The container failed to start"
    exit 1
fi