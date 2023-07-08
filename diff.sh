#!/bin/bash
set -euxo pipefail

sed "s/BBOX/$*/g" diff.sql | psql -h localhost -U postgres
