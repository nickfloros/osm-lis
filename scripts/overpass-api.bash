#!/bin/bash

help() {
  echo "script to controll docker internaces of overpass api"
  echo "usage : overpass-api.bash [cmd] [area]"
  echo "cmd : [deploy|start|stop]  "
  echo "area : [ireland | great-britain | isle-of-man | guernsey-jersey | wales | scotland | england] "

}



cmd=$1
region=""
rootPort=7000
echo $1 $2

dockerName="overpass-${2}"

case "$2" in 

  great-britain)
   region="great-britain"
   apiPort=$rootPort
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
  england)
    region="great-britain/england"
    apiPort=$(($rootPort+4))
    ;;
  wales) 
    region="great-britain/wales"
    apiPort=$(($rootPort+5))
    ;;
   scotland)
     region="great-britain/scotland"
     apiPort=$(($rootPort+6))
     ;; 
   hampshire)
     region="great-britain/england/hampshire"
     apiPort=$(($rootPort+7))

     ;;
 *)
   echo "region $2 not supported"
   help
   exit 1
esac

echo $region $apiPort

case "$1" in 
  deploy) 
    ./overpass-api-deploy.bash ${dockerName} ${region} ${port}
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

