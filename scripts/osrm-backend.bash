#!/bin/bash

help() {
  echo "script to controll docker internaces of overpass api"
  echo "usage : osrm-backend.bash [cmd] [area]"
  echo "cmd : [deploy|start|stop]  "
  echo "area : [ireland | great-britain | isle-of-man | guernsey-jersey | wales | scotland | england|monaco] "

}



cmd=$1
region=""
rootPort=7120
rootStore="${HOME}/opt/open-street-dat"
echo $1 $2


case "$2" in

  great-britain)
   region="great-britain"
   apiPort= rootPort
   ;;
  ireland-and-northen-ireland)
   region="irenland-and-northen-ireland"
   apiPort=$(( $rootPort+1))
   ;;
  isle-of-man)
    region="isle-of-man"
    apiPort=$(($rootPort+2))
    ;;
 guernsey-jersey)
    region="guernsey-jersey"
    apiPort=$(($rootPort+3))
    ;;
 monaco)
    region="monaco"
    apiPort=$(($rootPort+4))
    ;;
 *)
   echo "region $2 not supported"
   help
   exit 1
esac

dockerName="osrm-backend--${region}"
echo $region $apiPort

case "$1" in
  deploy)
    ./osrm-backend-deploy.bash ${region} ${port}
    ;;
  start)
    echo "restarting ${dockerName}"
    docker restart ${dockerName}
    ;;
  stop)
    echo "stop ${dockerName}"
    docker stop ${dockerName}
    ;;
  *)
    echo "cmd $1 not supported"
    help
    exit 1
esac

