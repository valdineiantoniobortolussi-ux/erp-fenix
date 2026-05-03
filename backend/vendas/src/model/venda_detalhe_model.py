from src import db
from src.model.produto_model import ProdutoModel


class VendaDetalheModel(db.Model):
    __tablename__ = 'venda_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Float)
    valor_unitario = db.Column(db.Float)
    valor_subtotal = db.Column(db.Float)
    taxa_desconto = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    id_venda_cabecalho = db.Column(db.Integer, db.ForeignKey('venda_cabecalho.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_venda_cabecalho = data.get('idVendaCabecalho')
        self.id_produto = data.get('idProduto')
        self.quantidade = data.get('quantidade')
        self.valor_unitario = data.get('valorUnitario')
        self.valor_subtotal = data.get('valorSubtotal')
        self.taxa_desconto = data.get('taxaDesconto')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_total = data.get('valorTotal')

    def serialize(self):
        return {
            'id': self.id,
            'idVendaCabecalho': self.id_venda_cabecalho,
            'idProduto': self.id_produto,
            'quantidade': self.quantidade,
            'valorUnitario': self.valor_unitario,
            'valorSubtotal': self.valor_subtotal,
            'taxaDesconto': self.taxa_desconto,
            'valorDesconto': self.valor_desconto,
            'valorTotal': self.valor_total,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }