from src import db
from src.model.produto_model import ProdutoModel


class CompraPedidoDetalheModel(db.Model):
    __tablename__ = 'compra_pedido_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Float)
    valor_unitario = db.Column(db.Float)
    valor_subtotal = db.Column(db.Float)
    taxa_desconto = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    cst = db.Column(db.String(2))
    csosn = db.Column(db.String(3))
    cfop = db.Column(db.Integer)
    base_calculo_icms = db.Column(db.Float)
    valor_icms = db.Column(db.Float)
    valor_ipi = db.Column(db.Float)
    aliquota_icms = db.Column(db.Float)
    aliquota_ipi = db.Column(db.Float)
    id_compra_pedido = db.Column(db.Integer, db.ForeignKey('compra_pedido.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_compra_pedido = data.get('idCompraPedido')
        self.id_produto = data.get('idProduto')
        self.quantidade = data.get('quantidade')
        self.valor_unitario = data.get('valorUnitario')
        self.valor_subtotal = data.get('valorSubtotal')
        self.taxa_desconto = data.get('taxaDesconto')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_total = data.get('valorTotal')
        self.cst = data.get('cst')
        self.csosn = data.get('csosn')
        self.cfop = data.get('cfop')
        self.base_calculo_icms = data.get('baseCalculoIcms')
        self.valor_icms = data.get('valorIcms')
        self.valor_ipi = data.get('valorIpi')
        self.aliquota_icms = data.get('aliquotaIcms')
        self.aliquota_ipi = data.get('aliquotaIpi')

    def serialize(self):
        return {
            'id': self.id,
            'idCompraPedido': self.id_compra_pedido,
            'idProduto': self.id_produto,
            'quantidade': self.quantidade,
            'valorUnitario': self.valor_unitario,
            'valorSubtotal': self.valor_subtotal,
            'taxaDesconto': self.taxa_desconto,
            'valorDesconto': self.valor_desconto,
            'valorTotal': self.valor_total,
            'cst': self.cst,
            'csosn': self.csosn,
            'cfop': self.cfop,
            'baseCalculoIcms': self.base_calculo_icms,
            'valorIcms': self.valor_icms,
            'valorIpi': self.valor_ipi,
            'aliquotaIcms': self.aliquota_icms,
            'aliquotaIpi': self.aliquota_ipi,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }