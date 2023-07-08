#!/bin/bash
set -euxo pipefail

docker run --rm \
  --env POSTGRES_HOST_AUTH_METHOD=trust \
  --publish 5432:5432 \
  postgis/postgis:15-3.3-alpine
