from src import db
from src.model.wms_ordem_separacao_det_model import WmsOrdemSeparacaoDetModel


class WmsOrdemSeparacaoCabModel(db.Model):
    __tablename__ = 'wms_ordem_separacao_cab'

    id = db.Column(db.Integer, primary_key=True)
    origem = db.Column(db.String(1))
    data_solicitacao = db.Column(db.DateTime)
    data_limite = db.Column(db.DateTime)

    wms_ordem_separacao_det_model_list = db.relationship('WmsOrdemSeparacaoDetModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.origem = data.get('origem')
        self.data_solicitacao = data.get('dataSolicitacao')
        self.data_limite = data.get('dataLimite')

    def serialize(self):
        return {
            'id': self.id,
            'origem': self.origem,
            'dataSolicitacao': self.data_solicitacao.isoformat(),
            'dataLimite': self.data_limite.isoformat(),
            'wmsOrdemSeparacaoDetModelList': [wms_ordem_separacao_det_model.serialize() for wms_ordem_separacao_det_model in self.wms_ordem_separacao_det_model_list],
        }