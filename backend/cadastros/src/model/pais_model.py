from src import db


class PaisModel(db.Model):
    __tablename__ = 'pais'

    id = db.Column(db.Integer, primary_key=True)
    nome_ptbr = db.Column(db.String(100))
    nome_en = db.Column(db.String(100))
    codigo = db.Column(db.Integer)
    sigla2 = db.Column(db.String(2))
    sigla3 = db.Column(db.String(3))
    codigo_bacen = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.nome_ptbr = data.get('nomePtbr')
        self.nome_en = data.get('nomeEn')
        self.codigo = data.get('codigo')
        self.sigla2 = data.get('sigla2')
        self.sigla3 = data.get('sigla3')
        self.codigo_bacen = data.get('codigoBacen')

    def serialize(self):
        return {
            'id': self.id,
            'nomePtbr': self.nome_ptbr,
            'nomeEn': self.nome_en,
            'codigo': self.codigo,
            'sigla2': self.sigla2,
            'sigla3': self.sigla3,
            'codigoBacen': self.codigo_bacen,
        }