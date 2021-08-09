#!/bin/bash

area=$1

if [ ! -d "${PWD}/data/${area}" ]
then
	echo ${PWD}/${area} does not exist
	echo "options are great-britain | berlin"
    echo Aborting
    exit 1
fi

if [ ! -f "${PWD}/data/${area}/${area}-latest.osm.pbf" ]
then
	echo "${PWD}/${area}/${area}-latest.osm.pbf does not exist"
    echo aborting
    exit 1
fi

#docker run --name osrm-${area} -d -i -p 5000:5000 -v "${PWD}/data/${area}:/data" osrm/osrm-backend osrm-routed --algorithm mld /data/${area}-latest.osrm

docker restart osrm-${area}