try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup



config = {
    'description': 'ASDC Multicatalogs search',
    'author': 'fmoscato',
    'url': '',
    'version':'0.2', 
    'download_url': 'Where to download it.',
    'author_email': 'fmoscato@asdc.asi.it',
    'install_requires': ['nose', 'pymongo', 'bottle'],
    'packages': ['multicatalogsSearch'],
    'scripts': [],
    'name': 'MulticatalogsSearch',
    'long_description': open('README.md').read(),
    'entry_points': {
        'console_scripts': [
            'serve = multicatalogsSearch.catalogs:run_server',
                           ]
                    },
    'package_data': {
        'multicatalogsSearch': ['static/*', 'js/*.js','js/library/*.js', 'views/*.tpl', '*.cfg'],
       },
        'include_package_data': True
}

setup(**config)
