from src import db
from src.model.produto_model import ProdutoModel


class WmsRecebimentoDetalheModel(db.Model):
    __tablename__ = 'wms_recebimento_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    quantidade_volume = db.Column(db.Integer)
    quantidade_item_por_volume = db.Column(db.Integer)
    quantidade_recebida = db.Column(db.Integer)
    destino = db.Column(db.String(1))
    id_wms_recebimento_cabecalho = db.Column(db.Integer, db.ForeignKey('wms_recebimento_cabecalho.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_wms_recebimento_cabecalho = data.get('idWmsRecebimentoCabecalho')
        self.id_produto = data.get('idProduto')
        self.quantidade_volume = data.get('quantidadeVolume')
        self.quantidade_item_por_volume = data.get('quantidadeItemPorVolume')
        self.quantidade_recebida = data.get('quantidadeRecebida')
        self.destino = data.get('destino')

    def serialize(self):
        return {
            'id': self.id,
            'idWmsRecebimentoCabecalho': self.id_wms_recebimento_cabecalho,
            'idProduto': self.id_produto,
            'quantidadeVolume': self.quantidade_volume,
            'quantidadeItemPorVolume': self.quantidade_item_por_volume,
            'quantidadeRecebida': self.quantidade_recebida,
            'destino': self.destino,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }