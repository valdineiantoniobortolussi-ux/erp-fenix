from src import db
from src.model.wms_ordem_separacao_det_model import WmsOrdemSeparacaoDetModel
from src.model.wms_armazenamento_model import WmsArmazenamentoModel


class WmsExpedicaoModel(db.Model):
    __tablename__ = 'wms_expedicao'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Integer)
    data_saida = db.Column(db.DateTime)
    id_wms_ordem_separacao_det = db.Column(db.Integer, db.ForeignKey('wms_ordem_separacao_det.id'))
    id_wms_armazenamento = db.Column(db.Integer, db.ForeignKey('wms_armazenamento.id'))

    wms_ordem_separacao_det_model = db.relationship('WmsOrdemSeparacaoDetModel', foreign_keys=[id_wms_ordem_separacao_det])
    wms_armazenamento_model = db.relationship('WmsArmazenamentoModel', foreign_keys=[id_wms_armazenamento])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_wms_ordem_separacao_det = data.get('idWmsOrdemSeparacaoDet')
        self.id_wms_armazenamento = data.get('idWmsArmazenamento')
        self.quantidade = data.get('quantidade')
        self.data_saida = data.get('dataSaida')

    def serialize(self):
        return {
            'id': self.id,
            'idWmsOrdemSeparacaoDet': self.id_wms_ordem_separacao_det,
            'idWmsArmazenamento': self.id_wms_armazenamento,
            'quantidade': self.quantidade,
            'dataSaida': self.data_saida.isoformat(),
            'wmsOrdemSeparacaoDetModel': self.wms_ordem_separacao_det_model.serialize() if self.wms_ordem_separacao_det_model else None,
            'wmsArmazenamentoModel': self.wms_armazenamento_model.serialize() if self.wms_armazenamento_model else None,
        }