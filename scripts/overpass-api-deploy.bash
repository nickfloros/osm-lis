#!/bin/bash

function validate_url(){
  if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
    return 1
  else
    echo "$2 does not exit"
    exit 1
  fi
}

 dockerName=$1
 region=$2
 port=$3 


 overpassUrl="http://download.geofabrik.de/europe/${region}-latest.osm.bz2"
 validate_url "${overpassUrl}" "${region}" 
 
# overpassDiff="http://download.openstreetmap.fr/replication/europe/${region}/minute/"
# validate_url "${region}" "${overpassDiff}"

 hostStore="$HOME/docker/data/overpass_db/${region}/"

 echo "deploying $dockerName $region $port $hostStore"

 docker run \
  -e OVERPASS_META=yes \
  -e OVERPASS_MODE=init \
  -e OVERPASS_PLANET_URL="${overpassUrl}" \
  -e OVERPASS_RULES_LOAD=10 \
  -v "${hostStore}":/db \
  -p "${port}":80 \
  -i -t \
  --name "${dockerName}" wiktorn/overpass-api

