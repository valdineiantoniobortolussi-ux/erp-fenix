from src import db
from src.model.cte_ferroviario_model import CteFerroviarioModel


class CteFerroviarioVagaoModel(db.Model):
    __tablename__ = 'cte_ferroviario_vagao'

    id = db.Column(db.Integer, primary_key=True)
    numero_vagao = db.Column(db.Integer)
    capacidade = db.Column(db.Float)
    tipo_vagao = db.Column(db.String(3))
    peso_real = db.Column(db.Float)
    peso_bc = db.Column(db.Float)
    id_cte_ferroviario = db.Column(db.Integer, db.ForeignKey('cte_ferroviario.id'))

    cte_ferroviario_model = db.relationship('CteFerroviarioModel', foreign_keys=[id_cte_ferroviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_ferroviario = data.get('idCteFerroviario')
        self.numero_vagao = data.get('numeroVagao')
        self.capacidade = data.get('capacidade')
        self.tipo_vagao = data.get('tipoVagao')
        self.peso_real = data.get('pesoReal')
        self.peso_bc = data.get('pesoBc')

    def serialize(self):
        return {
            'id': self.id,
            'idCteFerroviario': self.id_cte_ferroviario,
            'numeroVagao': self.numero_vagao,
            'capacidade': self.capacidade,
            'tipoVagao': self.tipo_vagao,
            'pesoReal': self.peso_real,
            'pesoBc': self.peso_bc,
            'cteFerroviarioModel': self.cte_ferroviario_model.serialize() if self.cte_ferroviario_model else None,
        }