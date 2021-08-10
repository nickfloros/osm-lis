#!/bin/bash

region=$1
rootStore=$2
port=$3
dataStore=${rootStore}/${region}

function validate_url(){
  if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
    return 0
  else
    echo "region $2 does not exit in $1"
    exit 1
  fi
}

function help() {
  echo "osrm-backend-deploy.bash [region] [rootStore] [port]"
  echo "region : opensteet map region for which we want to host osrm backend"
  echo "rootStore : is the root location where we want to permanetly store the osrm dataset for the region identified above. The data will be stored in \$rootStore/\$region" 
  echo "port : is the host port we will docker will accept requests"
}

if [ ! -d "${rootStore}" ]; then 
	echo "rootStore in ${rootStore} not found ... aborting"
	help
	exit 1
fi

if [ ! -d "${dataStore}" ]; then
    echo "creating ${dataStore}"
    mkdir -p ${dataStore}
fi

latest=${region}-latest
pbf=${latest}.osm.pbf
osrm=${latest}.osrm

pbfUrl=http://download.geofabrik.de/europe/${pbf}

validate_url ${pbfUrl} ${region}

wget -O ${dataStore}/${region}-latest.osm.pbf ${pbfUrl}

if [ ! -f "${dataStore}/${pbf}" ]; then
    echo "${dataStore}/${pbf} does not exist"
    echo aborting
    exit 1
fi

 
docker run -t -v ${dataStore}:/data osrm/osrm-backend osrm-extract -p /opt/car.lua /data/${pbf}

docker run -t -v ${dataStore}:/data osrm/osrm-backend osrm-partition /data/${osrm}
docker run -t -v ${dataStore}:/data osrm/osrm-backend osrm-customize /data/${osrm}

docker run -d -i -p ${port}:5000 -v "${dataStore}:/data" --name osrm-backend-${region} osrm/osrm-backend osrm-routed --algorithm mld /data/${osrm}

