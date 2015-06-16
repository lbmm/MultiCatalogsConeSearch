DISTANCE_MULTIPLIER = 57.2957795*60/6371000
ARC_MIN_CONVERSION = 0.00029088821*6371000


def cone_search_catalog(db, catalog, RA, DEC, radius, all_fields=False):

    cursor = db[catalog].aggregate([{'$geoNear': {'near': {'type': "Point", 'coordinates': [float(RA)-180, float(DEC)]},
                                                  'distanceField': "dist", 'spherical': True,
                                                  'maxDistance': float(radius) * ARC_MIN_CONVERSION,
                                                  'distanceMultiplier': DISTANCE_MULTIPLIER}
                                     }])
    results = []

    for values in cursor['result']:

        values['catalog_name'] = catalog
        #replacing unicode chart
        results.append(values)

    return results
