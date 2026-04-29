from src import db
from src.model.venda_orcamento_detalhe_model import VendaOrcamentoDetalheModel
from src.model.venda_condicoes_pagamento_model import VendaCondicoesPagamentoModel
from src.model.view_pessoa_vendedor_model import ViewPessoaVendedorModel
from src.model.view_pessoa_transportadora_model import ViewPessoaTransportadoraModel
from src.model.view_pessoa_cliente_model import ViewPessoaClienteModel


class VendaOrcamentoCabecalhoModel(db.Model):
    __tablename__ = 'venda_orcamento_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    tipo_frete = db.Column(db.String(1))
    codigo = db.Column(db.String(20))
    data_cadastro = db.Column(db.DateTime)
    data_entrega = db.Column(db.DateTime)
    data_validade = db.Column(db.DateTime)
    valor_subtotal = db.Column(db.Float)
    valor_frete = db.Column(db.Float)
    taxa_comissao = db.Column(db.Float)
    valor_comissao = db.Column(db.Float)
    taxa_desconto = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    observacao = db.Column(db.Text)
    id_venda_condicoes_pagamento = db.Column(db.Integer, db.ForeignKey('venda_condicoes_pagamento.id'))
    id_vendedor = db.Column(db.Integer, db.ForeignKey('view_pessoa_vendedor.id'))
    id_transportadora = db.Column(db.Integer, db.ForeignKey('view_pessoa_transportadora.id'))
    id_cliente = db.Column(db.Integer, db.ForeignKey('view_pessoa_cliente.id'))

    venda_orcamento_detalhe_model_list = db.relationship('VendaOrcamentoDetalheModel', lazy='dynamic')
    venda_condicoes_pagamento_model = db.relationship('VendaCondicoesPagamentoModel', foreign_keys=[id_venda_condicoes_pagamento])
    view_pessoa_vendedor_model = db.relationship('ViewPessoaVendedorModel', foreign_keys=[id_vendedor])
    view_pessoa_transportadora_model = db.relationship('ViewPessoaTransportadoraModel', foreign_keys=[id_transportadora])
    view_pessoa_cliente_model = db.relationship('ViewPessoaClienteModel', foreign_keys=[id_cliente])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_vendedor = data.get('idVendedor')
        self.id_cliente = data.get('idCliente')
        self.id_venda_condicoes_pagamento = data.get('idVendaCondicoesPagamento')
        self.id_transportadora = data.get('idTransportadora')
        self.tipo_frete = data.get('tipoFrete')
        self.codigo = data.get('codigo')
        self.data_cadastro = data.get('dataCadastro')
        self.data_entrega = data.get('dataEntrega')
        self.data_validade = data.get('dataValidade')
        self.valor_subtotal = data.get('valorSubtotal')
        self.valor_frete = data.get('valorFrete')
        self.taxa_comissao = data.get('taxaComissao')
        self.valor_comissao = data.get('valorComissao')
        self.taxa_desconto = data.get('taxaDesconto')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_total = data.get('valorTotal')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idVendedor': self.id_vendedor,
            'idCliente': self.id_cliente,
            'idVendaCondicoesPagamento': self.id_venda_condicoes_pagamento,
            'idTransportadora': self.id_transportadora,
            'tipoFrete': self.tipo_frete,
            'codigo': self.codigo,
            'dataCadastro': self.data_cadastro.isoformat(),
            'dataEntrega': self.data_entrega.isoformat(),
            'dataValidade': self.data_validade.isoformat(),
            'valorSubtotal': self.valor_subtotal,
            'valorFrete': self.valor_frete,
            'taxaComissao': self.taxa_comissao,
            'valorComissao': self.valor_comissao,
            'taxaDesconto': self.taxa_desconto,
            'valorDesconto': self.valor_desconto,
            'valorTotal': self.valor_total,
            'observacao': self.observacao,
            'vendaOrcamentoDetalheModelList': [venda_orcamento_detalhe_model.serialize() for venda_orcamento_detalhe_model in self.venda_orcamento_detalhe_model_list],
            'vendaCondicoesPagamentoModel': self.venda_condicoes_pagamento_model.serialize() if self.venda_condicoes_pagamento_model else None,
            'viewPessoaVendedorModel': self.view_pessoa_vendedor_model.serialize() if self.view_pessoa_vendedor_model else None,
            'viewPessoaTransportadoraModel': self.view_pessoa_transportadora_model.serialize() if self.view_pessoa_transportadora_model else None,
            'viewPessoaClienteModel': self.view_pessoa_cliente_model.serialize() if self.view_pessoa_cliente_model else None,
        }