#!/bin/bash
set -euxo pipefail

curl \
  "https://download.geofabrik.de/europe/germany/nordrhein-westfalen-latest.osm.pbf" \
  -z "data/nrw.osm.pbf" \
  -o "data/nrw.osm.pbf"

ogr2ogr \
  --config PG_USE_COPY YES \
  -f PostgreSQL "PG:host=localhost user=postgres" data/nrw.osm.pbf \
  -select osm_id -where "building is not NULL" \
  -t_srs EPSG:4326 \
  -nln nrw_osm \
  multipolygons
