from src import db
from src.model.produto_model import ProdutoModel


class CompraCotacaoDetalheModel(db.Model):
    __tablename__ = 'compra_cotacao_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Float)
    valor_unitario = db.Column(db.Float)
    valor_subtotal = db.Column(db.Float)
    taxa_desconto = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))
    id_compra_cotacao = db.Column(db.Integer, db.ForeignKey('compra_cotacao.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_produto = data.get('idProduto')
        self.quantidade = data.get('quantidade')
        self.valor_unitario = data.get('valorUnitario')
        self.valor_subtotal = data.get('valorSubtotal')
        self.taxa_desconto = data.get('taxaDesconto')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_total = data.get('valorTotal')
        self.id_compra_cotacao = data.get('idCompraCotacao')

    def serialize(self):
        return {
            'id': self.id,
            'idProduto': self.id_produto,
            'quantidade': self.quantidade,
            'valorUnitario': self.valor_unitario,
            'valorSubtotal': self.valor_subtotal,
            'taxaDesconto': self.taxa_desconto,
            'valorDesconto': self.valor_desconto,
            'valorTotal': self.valor_total,
            'idCompraCotacao': self.id_compra_cotacao,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }