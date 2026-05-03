from src import db
from src.model.produto_model import ProdutoModel


class CompraRequisicaoDetalheModel(db.Model):
    __tablename__ = 'compra_requisicao_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Float)
    id_compra_requisicao = db.Column(db.Integer, db.ForeignKey('compra_requisicao.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_compra_requisicao = data.get('idCompraRequisicao')
        self.id_produto = data.get('idProduto')
        self.quantidade = data.get('quantidade')

    def serialize(self):
        return {
            'id': self.id,
            'idCompraRequisicao': self.id_compra_requisicao,
            'idProduto': self.id_produto,
            'quantidade': self.quantidade,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }