import os
import argparse

import pymongo
import bottle

import catalogsDAO
import metaData



#this route the static files
@bottle.route('/static/:filename#.*#')
def server_static(filename):
    PATH_STATIC = '%s/static' % ROOT

    try:
        if not os.path.exists(PATH_STATIC+"/"+filename):
            return bottle.template("not_found")
    except Exception as e:
        return bottle.redirect("/internal_error")

    return bottle.static_file(filename, root=PATH_STATIC)

#this route the js files
@bottle.route('/js/:filename#.*#')
def server_js(filename):
    PATH_JS = '%s/js' % ROOT
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


def isFloat(str):
    try:
        float(str)
        return True
    except ValueError as e:
        return False


@bottle.post("/cone_search")
def process_cone_search():

    catalogs_to_search = bottle.request.forms.getall('catalogs')
    ra = bottle.request.forms.get('ra')
    dec = bottle.request.forms.get('dec')
    radius = bottle.request.forms.get('radius')

    if isFloat(ra) and isFloat(dec):

        data = catalogs.search_catalogs(catalogs_to_search, ra, dec, radius)
        return bottle.template('show_entries', data=data, hyper_links=info_catalogs.get_all_links(),
                               extra_columns=info_catalogs.get_all_columns(),
                               ra=ra, Dec=dec, radius=radius)
    else:
        l = catalogs.get_catalogs()
        return bottle.template('search_catalogs', dict(catalogs=l), error="please provide right input format",
                               ra=ra, dec=dec)


@bottle.get('/internal_error')
@bottle.view('error_template')
def present_internal_error():
    return {'error': "System has encountered a DB error"}


connection_string = "mongodb://localhost"
connection = pymongo.MongoClient(connection_string)
database = connection.ASDC_catalogs

catalogs = catalogsDAO.CatalogsDAO(database)
info_catalogs = metaData.MetaData()


def run_server():

    import socket
    bottle.run(host=socket.gethostname(), port=8082)  # Start the webserver running and wait for requests


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='python catalogs.py will start the catalogs cone search service')
    parser.add_argument('-d', '--dir', help='where to find the statics files', required=True)
    args = vars(parser.parse_args())

    ROOT = args['dir']

    bottle.debug(True)
    run_server()
