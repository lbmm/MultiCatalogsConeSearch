import os

import pymongo
import bottle

import catalogsDAO
import metaData

ROOT = ''
PATH_JS = '%s/js' % ROOT
PATH_STATIC = '%s/static' % ROOT

#this route the static files
@bottle.route('/static/:filename#.*#')
def server_static(filename):

    try:
        if not os.path.exists(PATH_STATIC+"/"+filename):
            return bottle.template("not_found")
    except Exception as e:
        return bottle.redirect("/internal_error")

    return bottle.static_file(filename, root=PATH_STATIC)

#this route the js files
@bottle.route('/js/:filename#.*#')
def server_js(filename):
    try:
        if not os.path.exists(PATH_JS+"/"+filename):
            return bottle.template("not_found")
    except Exception as e:
        return bottle.redirect("/internal_error")

    return bottle.static_file(filename, root=PATH_JS)


@bottle.route('/')
def catalogs_index():

    # even if there is no logged in user, we can show the blog
    l = catalogs.get_catalogs()
    return bottle.template('search_catalogs', dict(catalogs=l))




@bottle.post("/cone_search")
def process_cone_search():

    catalogs_to_search = bottle.request.forms.getall('catalogs')
    ra = bottle.request.forms.get('ra')
    dec = bottle.request.forms.get('dec')
    radius = bottle.request.forms.get('radius')

    data = catalogs.search_catalogs(catalogs_to_search, ra, dec, radius)
    return bottle.template('show_entries', data=data, hyper_links=info_catalogs.get_all_links(),
                           extra_columns=info_catalogs.get_all_columns(),
                           ra=ra, Dec=dec, radius=radius)





@bottle.get('/internal_error')
@bottle.view('error_template')
def present_internal_error():
    return {'error': "System has encountered a DB error"}


connection_string = "mongodb://localhost"
connection = pymongo.MongoClient(connection_string)
database = connection.ASDC_catalogs

catalogs = catalogsDAO.CatalogsDAO(database)
info_catalogs = metaData.MetaData()


bottle.debug(True)
bottle.run(host='localhost', port=8082)         # Start the webserver running and wait for requests

