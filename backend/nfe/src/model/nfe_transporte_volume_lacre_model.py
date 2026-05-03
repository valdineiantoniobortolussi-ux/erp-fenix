from src import db
from src.model.nfe_transporte_volume_model import NfeTransporteVolumeModel


class NfeTransporteVolumeLacreModel(db.Model):
    __tablename__ = 'nfe_transporte_volume_lacre'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(60))
    id_nfe_transporte_volume = db.Column(db.Integer, db.ForeignKey('nfe_transporte_volume.id'))

    nfe_transporte_volume_model = db.relationship('NfeTransporteVolumeModel', foreign_keys=[id_nfe_transporte_volume])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_transporte_volume = data.get('idNfeTransporteVolume')
        self.numero = data.get('numero')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeTransporteVolume': self.id_nfe_transporte_volume,
            'numero': self.numero,
            'nfeTransporteVolumeModel': self.nfe_transporte_volume_model.serialize() if self.nfe_transporte_volume_model else None,
        }