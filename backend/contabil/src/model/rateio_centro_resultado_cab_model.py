from src import db
from src.model.rateio_centro_resultado_det_model import RateioCentroResultadoDetModel
from src.model.centro_resultado_model import CentroResultadoModel


class RateioCentroResultadoCabModel(db.Model):
    __tablename__ = 'rateio_centro_resultado_cab'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))
    id_centro_resultado = db.Column(db.Integer, db.ForeignKey('centro_resultado.id'))

    rateio_centro_resultado_det_model_list = db.relationship('RateioCentroResultadoDetModel', lazy='dynamic')
    centro_resultado_model = db.relationship('CentroResultadoModel', foreign_keys=[id_centro_resultado])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_centro_resultado = data.get('idCentroResultado')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idCentroResultado': self.id_centro_resultado,
            'descricao': self.descricao,
            'rateioCentroResultadoDetModelList': [rateio_centro_resultado_det_model.serialize() for rateio_centro_resultado_det_model in self.rateio_centro_resultado_det_model_list],
            'centroResultadoModel': self.centro_resultado_model.serialize() if self.centro_resultado_model else None,
        }