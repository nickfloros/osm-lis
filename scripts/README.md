
# overpass-api

This deploys overpass turbo api. This script deploys a docker instance hosting overpass turbo api , making use of https://github.com/wiktorn/Overpass-API

The `overpass-api.bash` manages deployment of the following openstreet regions
| region | port |
|--------|------|
|great-britain |7000 |
|ireland | 7001|
|isle-of-man | 7002 |
|guernsey-jersey | 7003 |
|england | 7004|
|wales | 7005|
|scotland | 7006|

The port number of each region is controlled in `overpass-api.bash`

Data sets are uploaded from http://download.openstreetmap.fr/replication/europe and are stored in `/data/docker/overpass_db`

To deploy overpass turbo api do the following 
```
  ./overpass-api.bash  deploy  hampshire

```

to stop turbo api
```
  ./overpass-api.bash stop hampshire
```

to start overpass api
```
  ./overpass-api.bash start hampshire
```

# osrm-backend
This deploys osrm-backend routing enginee (see https://github.com/Project-OSRM/osrm-backend)
to deploy 
```
  ./osrm-backend.bash deploy monaco 
```

The `osrm-backend.bash` manages deployment of the following openstreet regions
| region | port |
|--------|------|
|great-britain |7120 |
|ireland | 7121|
|isle-of-man | 7122 |
|guernsey-jersey | 7123 |
|monaco | 7124 |

Datasets are uploaded from http://download.openstreetmap.fr/replication/europe.

The datastore uploaded are stored in `${HOME}/opt/open-street-data` . This is defined in `osrm-backend-deploy.bash`

to stop a docker instance
```
  ./osrm-backend.bash stop monaco
```

to start a docker instance
```
  ./osrm-backend.bash start monaco
```

