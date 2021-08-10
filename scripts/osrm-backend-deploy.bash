#!/bin/bash

area=$1
dataStore=$2/data/${area}

function validate_url(){
  if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
    return 0
  else
    echo "$2 does not exit"
    exit 1
  fi
}


if [ ! -d "${dataStore}" ]
then
    echo "creating ${dataStore}"
    mkdir -p ${dataStpre}
fi

if [ ! -f "${dataStore}/${area}-latest.osm.pbf" ]
then
    echo "${dataStore}/${area}-latest.osm.pbf does not exist
    echo aborting
    exit 1
fi

pbfUrl="http://download.geofabrik.de/europe/${area}-latest.osm.pbf"
validate_url "${osrmUrl}" "${area}"

wget -D ${dataStore}/${area}-latest.osm.pbf  ${pbfUrl}

docker run -t -v "${dataStore}:/data" osrm/osrm-backend osrm-extract -p /opt/car.lua /data/${area}-latest.osm.pbf

docker run -t -v "${dataStore}:/data" osrm/osrm-backend osrm-partition /data/${area}-latest.osrm
docker run -t -v "${dataStore}:/data" osrm/osrm-backend osrm-customize /data/${area}-latest.osrm
