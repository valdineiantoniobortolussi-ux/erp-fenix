from src import db
from src.model.centro_resultado_model import CentroResultadoModel


class RateioCentroResultadoDetModel(db.Model):
    __tablename__ = 'rateio_centro_resultado_det'

    id = db.Column(db.Integer, primary_key=True)
    porcento_rateio = db.Column(db.Float)
    id_rateio_centro_resul_cab = db.Column(db.Integer, db.ForeignKey('rateio_centro_resultado_cab.id'))
    id_centro_resultado_destino = db.Column(db.Integer, db.ForeignKey('centro_resultado.id'))

    centro_resultado_model = db.relationship('CentroResultadoModel', foreign_keys=[id_centro_resultado_destino])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_rateio_centro_resul_cab = data.get('idRateioCentroResulCab')
        self.id_centro_resultado_destino = data.get('idCentroResultadoDestino')
        self.porcento_rateio = data.get('porcentoRateio')

    def serialize(self):
        return {
            'id': self.id,
            'idRateioCentroResulCab': self.id_rateio_centro_resul_cab,
            'idCentroResultadoDestino': self.id_centro_resultado_destino,
            'porcentoRateio': self.porcento_rateio,
            'centroResultadoModel': self.centro_resultado_model.serialize() if self.centro_resultado_model else None,
        }