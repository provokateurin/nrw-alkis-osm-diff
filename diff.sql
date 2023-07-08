CREATE TABLE IF NOT EXISTS diff
(
    osm_id    VARCHAR,
    gml_id    VARCHAR,
    diff      geometry,
    osmarea   float,
    alkisarea float
);

INSERT INTO diff
SELECT osm_id,
       gml_id,
       diff,
       ST_Area(diff, true)      AS osmarea,
       ST_Area(alkisgeom, true) AS alkisarea
FROM (SELECT *, ST_Difference(alkisgeom, osmgeom) AS diff
      FROM (SELECT nrw_osm.osm_id,
                   nrw_alkis.gml_id,
                   nrw_alkis.geometrie            AS alkisgeom,
                   ST_Union(nrw_osm.wkb_geometry) AS osmgeom
            FROM nrw_alkis
                     LEFT OUTER JOIN nrw_osm
                                     ON (ST_Intersects(ST_makeValid(nrw_osm.wkb_geometry),
                                                       ST_makeValid(nrw_alkis.geometrie)))
            WHERE nrw_alkis.geometrie @ ST_MakeEnvelope(BBOX)
              AND nrw_osm.wkb_geometry @ ST_MakeEnvelope(BBOX)
            GROUP BY nrw_osm.osm_id, nrw_alkis.gml_id, nrw_alkis.geometrie) geoms) diff;
