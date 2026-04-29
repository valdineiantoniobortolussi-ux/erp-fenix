from src import db
from src.model.nfe_transporte_model import NfeTransporteModel


class NfeTransporteReboqueModel(db.Model):
    __tablename__ = 'nfe_transporte_reboque'

    id = db.Column(db.Integer, primary_key=True)
    placa = db.Column(db.String(8))
    uf = db.Column(db.String(2))
    rntc = db.Column(db.String(20))
    vagao = db.Column(db.String(20))
    balsa = db.Column(db.String(20))
    id_nfe_transporte = db.Column(db.Integer, db.ForeignKey('nfe_transporte.id'))

    nfe_transporte_model = db.relationship('NfeTransporteModel', foreign_keys=[id_nfe_transporte])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_transporte = data.get('idNfeTransporte')
        self.placa = data.get('placa')
        self.uf = data.get('uf')
        self.rntc = data.get('rntc')
        self.vagao = data.get('vagao')
        self.balsa = data.get('balsa')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeTransporte': self.id_nfe_transporte,
            'placa': self.placa,
            'uf': self.uf,
            'rntc': self.rntc,
            'vagao': self.vagao,
            'balsa': self.balsa,
            'nfeTransporteModel': self.nfe_transporte_model.serialize() if self.nfe_transporte_model else None,
        }