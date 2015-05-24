import itertools

import geoNearUtilities as gn


# The Catalogs  Data Access Object handles interactions with the ASDC_catalogs Database
class CatalogsDAO:

    # constructor for the class
    def __init__(self, database):
        self.db = database
        self.catalogs = database.collection_names(False)

    # returns an array of catalogs names
    def get_catalogs(self):
        return self.catalogs

    def search_catalogs(self, catalogs_to_search, ra, dec, radius=5):

        tot_list = []
        meta_data = {}
        info_tot = []
        for cat in catalogs_to_search:
            result = gn.cone_search_catalog(self.db, cat, ra, dec, radius)
            tot_list.append(result)
            meta_data[cat] = len(result)

        info_tot.append(meta_data)
        info_tot.extend(list(itertools.chain.from_iterable(tot_list)))
        return info_tot













