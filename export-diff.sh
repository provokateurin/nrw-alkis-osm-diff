#!/bin/bash
set -euxo pipefail

rm -f data/nrw.diff.json
ogr2ogr \
  -f GeoJSON data/nrw.diff.json "PG:host=localhost user=postgres" \
  diff
