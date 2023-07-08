# NRW-ALKIS-OSM-diff

Experiment to diff buildings between OSM and ALKIS.

This is loosely based on https://github.com/flohoff/kreis-gt-alkis-nas-osm-diff.

## Steps

```bash
# Run the database. Keep it running in the background
./db.sh

# Download the data from OSM and load it into the database
./import-osm.sh

# Download the data from ALKIS and load it into the database
./import-alkis.sh

# Generate the diffs for a bounding box. The format is `xmin, ymin, xmax, ymax, srid`. For example: 6.3, 50.3, 6.5, 50.4, 4326
./diff.sh {{bbox}}
```

## Results

The easiest way is to use QGIS to connect to the PostGIS database.  
Alternatively you can run `./export-diff.sh` to export the diffs to GeoJSON.
