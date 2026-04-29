from src import db
from src.model.wms_recebimento_detalhe_model import WmsRecebimentoDetalheModel


class WmsArmazenamentoModel(db.Model):
    __tablename__ = 'wms_armazenamento'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Integer)
    id_wms_caixa = db.Column(db.Integer, db.ForeignKey('wms_caixa.id'))
    id_wms_recebimento_detalhe = db.Column(db.Integer, db.ForeignKey('wms_recebimento_detalhe.id'))

    wms_recebimento_detalhe_model = db.relationship('WmsRecebimentoDetalheModel', foreign_keys=[id_wms_recebimento_detalhe])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_wms_caixa = data.get('idWmsCaixa')
        self.id_wms_recebimento_detalhe = data.get('idWmsRecebimentoDetalhe')
        self.quantidade = data.get('quantidade')

    def serialize(self):
        return {
            'id': self.id,
            'idWmsCaixa': self.id_wms_caixa,
            'idWmsRecebimentoDetalhe': self.id_wms_recebimento_detalhe,
            'quantidade': self.quantidade,
            'wmsRecebimentoDetalheModel': self.wms_recebimento_detalhe_model.serialize() if self.wms_recebimento_detalhe_model else None,
        }