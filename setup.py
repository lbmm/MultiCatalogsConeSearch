try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

config = {
    'description': 'ASDC prototype for the multicatalog cone search based on MongoDB',
    'author': 'fmoscato',
    'url': '',
    'version' : 0.1,
    'download_url': 'Where to download it.',
    'author_email': 'fmoscato@asdc.asi.it',
    'install_requires': ['nose', 'pymongo', 'bottle'],
    'packages': ['multicatalogsSearch'],
    'scripts': [],
    'name': 'multicatalogsSearch',
    'long_description': open('README.md').read(),
    'entry_points': {
        'console_scripts': [
            'serve = multicatalogsSearch.catalogs:run_server',
            ]
        },
     'package_data':{
      'multicatalogsSearch': ['static/*', 'js/*.js', 'views/*.tpl'],
       },
     'include_package_data': True
}
