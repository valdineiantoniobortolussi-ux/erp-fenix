from src import db


class UfModel(db.Model):
    __tablename__ = 'uf'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    sigla = db.Column(db.String(2))
    codigo_ibge = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.sigla = data.get('sigla')
        self.codigo_ibge = data.get('codigoIbge')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'sigla': self.sigla,
            'codigoIbge': self.codigo_ibge,
        }