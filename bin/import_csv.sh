#!/bin/bash

dir_catalogs=csv_catalogs
catalog=$1
mongoimport -d ASDC_catalogs -c $catalog  --type csv --file $dir_catalogs/$catalog.csv --headerline

#mongo --eval "var collection_name=\"$catalog\""  < add_loc.js
