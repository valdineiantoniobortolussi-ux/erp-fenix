from src import db


class PatrimTaxaDepreciacaoModel(db.Model):
    __tablename__ = 'patrim_taxa_depreciacao'

    id = db.Column(db.Integer, primary_key=True)
    ncm = db.Column(db.String(8))
    bem = db.Column(db.String(250))
    vida = db.Column(db.Float)
    taxa = db.Column(db.Float)


    def mapping(self, data):
        self.id = data.get('id')
        self.ncm = data.get('ncm')
        self.bem = data.get('bem')
        self.vida = data.get('vida')
        self.taxa = data.get('taxa')

    def serialize(self):
        return {
            'id': self.id,
            'ncm': self.ncm,
            'bem': self.bem,
            'vida': self.vida,
            'taxa': self.taxa,
        }