#!/bin/bash

area=$1

if [ ! -d "${PWD}/data/${area}" ]
then
	echo ${PWD}/${area} does not exist
    echo aborting
    exit 1
fi

if [ ! -f "${PWD}/data/${area}/${area}-latest.osm.pbf" ]
then
	echo ${PWD}/${area}/${area}-latest.osm.pbf does not exist
    echo aborting
    exit 1
fi

docker run -t -v "${PWD}/data/${area}:/data" osrm/osrm-backend osrm-extract -p /opt/car.lua /data/${area}-latest.osm.pbf

docker run -t -v "${PWD}/data/${area}:/data" osrm/osrm-backend osrm-partition /data/${area}-latest.osrm
docker run -t -v "${PWD}/data/${area}:/data" osrm/osrm-backend osrm-customize /data/${area}-latest.osrm