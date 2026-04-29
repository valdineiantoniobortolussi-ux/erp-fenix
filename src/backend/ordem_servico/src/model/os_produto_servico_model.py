from src import db
from src.model.produto_model import ProdutoModel


class OsProdutoServicoModel(db.Model):
    __tablename__ = 'os_produto_servico'

    id = db.Column(db.Integer, primary_key=True)
    tipo = db.Column(db.String(1))
    complemento = db.Column(db.Text)
    quantidade = db.Column(db.Float)
    valor_unitario = db.Column(db.Float)
    valor_subtotal = db.Column(db.Float)
    taxa_desconto = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    id_os_abertura = db.Column(db.Integer, db.ForeignKey('os_abertura.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_os_abertura = data.get('idOsAbertura')
        self.id_produto = data.get('idProduto')
        self.tipo = data.get('tipo')
        self.complemento = data.get('complemento')
        self.quantidade = data.get('quantidade')
        self.valor_unitario = data.get('valorUnitario')
        self.valor_subtotal = data.get('valorSubtotal')
        self.taxa_desconto = data.get('taxaDesconto')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_total = data.get('valorTotal')

    def serialize(self):
        return {
            'id': self.id,
            'idOsAbertura': self.id_os_abertura,
            'idProduto': self.id_produto,
            'tipo': self.tipo,
            'complemento': self.complemento,
            'quantidade': self.quantidade,
            'valorUnitario': self.valor_unitario,
            'valorSubtotal': self.valor_subtotal,
            'taxaDesconto': self.taxa_desconto,
            'valorDesconto': self.valor_desconto,
            'valorTotal': self.valor_total,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }