from src import db
from src.model.produto_model import ProdutoModel


class EstoqueReajusteDetalheModel(db.Model):
    __tablename__ = 'estoque_reajuste_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    valor_original = db.Column(db.Float)
    valor_reajuste = db.Column(db.Float)
    id_estoque_reajuste_cabecalho = db.Column(db.Integer, db.ForeignKey('estoque_reajuste_cabecalho.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_estoque_reajuste_cabecalho = data.get('idEstoqueReajusteCabecalho')
        self.id_produto = data.get('idProduto')
        self.valor_original = data.get('valorOriginal')
        self.valor_reajuste = data.get('valorReajuste')

    def serialize(self):
        return {
            'id': self.id,
            'idEstoqueReajusteCabecalho': self.id_estoque_reajuste_cabecalho,
            'idProduto': self.id_produto,
            'valorOriginal': self.valor_original,
            'valorReajuste': self.valor_reajuste,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }