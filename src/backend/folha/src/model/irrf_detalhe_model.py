from src import db


class IrrfDetalheModel(db.Model):
    __tablename__ = 'irrf_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    faixa = db.Column(db.Integer)
    de = db.Column(db.Float)
    ate = db.Column(db.Float)
    taxa = db.Column(db.Float)
    desconto = db.Column(db.Float)
    id_irrf = db.Column(db.Integer, db.ForeignKey('irrf.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_irrf = data.get('idIrrf')
        self.faixa = data.get('faixa')
        self.de = data.get('de')
        self.ate = data.get('ate')
        self.taxa = data.get('taxa')
        self.desconto = data.get('desconto')

    def serialize(self):
        return {
            'id': self.id,
            'idIrrf': self.id_irrf,
            'faixa': self.faixa,
            'de': self.de,
            'ate': self.ate,
            'taxa': self.taxa,
            'desconto': self.desconto,
        }