#!/bin/bash

dir_catalogs=csv_catalogs
catalogs=$(ls $dir_catalogs/*.csv | tr '\n' '\0' | xargs -0 -n 1 basename)
for catalog in ${catalogs[@]}; do

   catalog_name="${catalog%.*}"
   mongoimport -d ASDC_catalogs -c $catalog_name  --type csv --file $dir_catalogs/$catalog --headerline
done
