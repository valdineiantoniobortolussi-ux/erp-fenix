from src import db
from src.model.produto_model import ProdutoModel


class WmsOrdemSeparacaoDetModel(db.Model):
    __tablename__ = 'wms_ordem_separacao_det'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Integer)
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))
    id_wms_ordem_separacao_cab = db.Column(db.Integer, db.ForeignKey('wms_ordem_separacao_cab.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_wms_ordem_separacao_cab = data.get('idWmsOrdemSeparacaoCab')
        self.id_produto = data.get('idProduto')
        self.quantidade = data.get('quantidade')

    def serialize(self):
        return {
            'id': self.id,
            'idWmsOrdemSeparacaoCab': self.id_wms_ordem_separacao_cab,
            'idProduto': self.id_produto,
            'quantidade': self.quantidade,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }