#! /bin/bash

# Convert csv files to shape using qgis_process

if [[ -n "$1" ]]; then
    cd "$(realpath $1)"
    for file in *; do
	if [ -f "$file" ]; then
            if [[ $file == *.csv ]]; then
  	    	if grep -q ° "$file"; then
  	            dms="yes"
            	else
                    dms="no"
	    	fi
                qgis_process run native:concavehull --no-python --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --INPUT=delimitedtext:"//file://"$(realpath "$file")"?type=csv&maxFields=10000&detectTypes=yes&xyDms="$dms"&xField=x&yField=y&crs=EPSG:4326&spatialIndex=no&subsetIndex=no&watchFile=no" --ALPHA=0.3 --HOLES=true --NO_MULTIGEOMETRY=false --OUTPUT=""$(realpath "${file%.*}.shp")""
            fi
        else
	    echo "Error: Empty folder"
        fi
    done
else
   echo "Usage: ./csv-to-shp.sh dirname"
fi
