from src import db
from src.model.tribut_icms_custom_det_model import TributIcmsCustomDetModel


class TributIcmsCustomCabModel(db.Model):
    __tablename__ = 'tribut_icms_custom_cab'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))
    origem_mercadoria = db.Column(db.String(1))

    tribut_icms_custom_det_model_list = db.relationship('TributIcmsCustomDetModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.descricao = data.get('descricao')
        self.origem_mercadoria = data.get('origemMercadoria')

    def serialize(self):
        return {
            'id': self.id,
            'descricao': self.descricao,
            'origemMercadoria': self.origem_mercadoria,
            'tributIcmsCustomDetModelList': [tribut_icms_custom_det_model.serialize() for tribut_icms_custom_det_model in self.tribut_icms_custom_det_model_list],
        }