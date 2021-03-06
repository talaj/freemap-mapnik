#!/bin/bash

gdal_merge.py -o hgt/merged.tif hgt/*_1arc_v3.tif
gdaldem hillshade -s 111120 -compute_edges -multidirectional hgt/merged.tif hgt/hillshade.tif
gdal_translate -of GTiff -co "TILED=YES" -a_srs "+proj=latlong" hgt/hillshade.tif hgt/hillshade_adapted.tif
gdalwarp -of GTiff -co "TILED=YES" -srcnodata 32767 -t_srs "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs +over" -rcs -order 3 -tr 30 30 -multi hgt/hillshade_adapted.tif hgt/hillshade_warped.tif
