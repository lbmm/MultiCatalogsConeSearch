import ConfigParser


class MetaData(ConfigParser.ConfigParser):

    def __init__(self):
        self.config = ConfigParser.ConfigParser()
        self.config.read('meta_data.cfg')

    def get_hyper_link(self, catalog):
        return self.config.get(catalog, 'link')

    def get_columns(self, catalog):
        return self.config.get(catalog, 'columns').split(",")

    def get_all_columns(self):
        sections = self.config.sections()
        return {s: self.config.get(s, 'columns').split(",") for s in sections}


    def get_all_links(self):
        sections = self.config.sections()
        return {s: self.config.get(s, 'link') for s in sections}
