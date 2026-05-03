from src import db


class SalarioFamiliaModel(db.Model):
    __tablename__ = 'salario_familia'

    id = db.Column(db.Integer, primary_key=True)
    faixa = db.Column(db.Integer)
    de = db.Column(db.Float)
    ate = db.Column(db.Float)
    valor = db.Column(db.Float)
    id_inss = db.Column(db.Integer, db.ForeignKey('inss.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_inss = data.get('idInss')
        self.faixa = data.get('faixa')
        self.de = data.get('de')
        self.ate = data.get('ate')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idInss': self.id_inss,
            'faixa': self.faixa,
            'de': self.de,
            'ate': self.ate,
            'valor': self.valor,
        }