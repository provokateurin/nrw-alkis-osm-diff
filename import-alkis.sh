#!/bin/bash
set -euxo pipefail

size=500000

for i in {0..19}; do
  offset=$((i * size))
  ogr2ogr \
    --config PG_USE_COPY YES \
    -f PostgreSQL "PG:host=localhost user=postgres" "WFS:https://www.wfs.nrw.de/geobasis/wfs_nw_alkis_vereinfacht?REQUEST=GetFeature&COUNT=$size&STARTINDEX=$offset" \
    -select gml_id -where "'ave:gfkzshh' LIKE '31001_%'" \
    -nlt CONVERT_TO_LINEAR \
    -t_srs EPSG:4326 \
    -makevalid \
    -skipfailures \
    -nln nrw_alkis \
    ave:GebaeudeBauwerk &
  sleep 1s # Add a delay to prevent the schema creation to race condition
done

wait
