from src import db
from src.model.uf_model import UfModel


class MunicipioModel(db.Model):
    __tablename__ = 'municipio'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    codigo_ibge = db.Column(db.Integer)
    codigo_receita_federal = db.Column(db.Integer)
    codigo_estadual = db.Column(db.Integer)
    id_uf = db.Column(db.Integer, db.ForeignKey('uf.id'))

    uf_model = db.relationship('UfModel', foreign_keys=[id_uf])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_uf = data.get('idUf')
        self.nome = data.get('nome')
        self.codigo_ibge = data.get('codigoIbge')
        self.codigo_receita_federal = data.get('codigoReceitaFederal')
        self.codigo_estadual = data.get('codigoEstadual')

    def serialize(self):
        return {
            'id': self.id,
            'idUf': self.id_uf,
            'nome': self.nome,
            'codigoIbge': self.codigo_ibge,
            'codigoReceitaFederal': self.codigo_receita_federal,
            'codigoEstadual': self.codigo_estadual,
            'ufModel': self.uf_model.serialize() if self.uf_model else None,
        }