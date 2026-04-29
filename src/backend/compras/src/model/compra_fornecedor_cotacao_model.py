from src import db
from src.model.view_pessoa_fornecedor_model import ViewPessoaFornecedorModel


class CompraFornecedorCotacaoModel(db.Model):
    __tablename__ = 'compra_fornecedor_cotacao'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(32))
    prazo_entrega = db.Column(db.String(50))
    venda_condicoes_pagamento = db.Column(db.String(50))
    valor_subtotal = db.Column(db.Float)
    taxa_desconto = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    id_fornecedor = db.Column(db.Integer, db.ForeignKey('view_pessoa_fornecedor.id'))
    id_compra_cotacao = db.Column(db.Integer, db.ForeignKey('compra_cotacao.id'))

    view_pessoa_fornecedor_model = db.relationship('ViewPessoaFornecedorModel', foreign_keys=[id_fornecedor])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_compra_cotacao = data.get('idCompraCotacao')
        self.id_fornecedor = data.get('idFornecedor')
        self.codigo = data.get('codigo')
        self.prazo_entrega = data.get('prazoEntrega')
        self.venda_condicoes_pagamento = data.get('vendaCondicoesPagamento')
        self.valor_subtotal = data.get('valorSubtotal')
        self.taxa_desconto = data.get('taxaDesconto')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_total = data.get('valorTotal')

    def serialize(self):
        return {
            'id': self.id,
            'idCompraCotacao': self.id_compra_cotacao,
            'idFornecedor': self.id_fornecedor,
            'codigo': self.codigo,
            'prazoEntrega': self.prazo_entrega,
            'vendaCondicoesPagamento': self.venda_condicoes_pagamento,
            'valorSubtotal': self.valor_subtotal,
            'taxaDesconto': self.taxa_desconto,
            'valorDesconto': self.valor_desconto,
            'valorTotal': self.valor_total,
            'viewPessoaFornecedorModel': self.view_pessoa_fornecedor_model.serialize() if self.view_pessoa_fornecedor_model else None,
        }