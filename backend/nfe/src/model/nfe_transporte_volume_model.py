from src import db
from src.model.nfe_transporte_model import NfeTransporteModel


class NfeTransporteVolumeModel(db.Model):
    __tablename__ = 'nfe_transporte_volume'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Integer)
    especie = db.Column(db.String(60))
    marca = db.Column(db.String(60))
    numeracao = db.Column(db.String(60))
    peso_liquido = db.Column(db.Float)
    peso_bruto = db.Column(db.Float)
    id_nfe_transporte = db.Column(db.Integer, db.ForeignKey('nfe_transporte.id'))

    nfe_transporte_model = db.relationship('NfeTransporteModel', foreign_keys=[id_nfe_transporte])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_transporte = data.get('idNfeTransporte')
        self.quantidade = data.get('quantidade')
        self.especie = data.get('especie')
        self.marca = data.get('marca')
        self.numeracao = data.get('numeracao')
        self.peso_liquido = data.get('pesoLiquido')
        self.peso_bruto = data.get('pesoBruto')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeTransporte': self.id_nfe_transporte,
            'quantidade': self.quantidade,
            'especie': self.especie,
            'marca': self.marca,
            'numeracao': self.numeracao,
            'pesoLiquido': self.peso_liquido,
            'pesoBruto': self.peso_bruto,
            'nfeTransporteModel': self.nfe_transporte_model.serialize() if self.nfe_transporte_model else None,
        }