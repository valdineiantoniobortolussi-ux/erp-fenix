from src import db
from src.model.venda_comissao_model import VendaComissaoModel
from src.model.venda_detalhe_model import VendaDetalheModel
from src.model.venda_frete_model import VendaFreteModel
from src.model.venda_condicoes_pagamento_model import VendaCondicoesPagamentoModel
from src.model.view_pessoa_vendedor_model import ViewPessoaVendedorModel
from src.model.view_pessoa_transportadora_model import ViewPessoaTransportadoraModel
from src.model.view_pessoa_cliente_model import ViewPessoaClienteModel
from src.model.venda_orcamento_cabecalho_model import VendaOrcamentoCabecalhoModel
from src.model.nota_fiscal_tipo_model import NotaFiscalTipoModel


class VendaCabecalhoModel(db.Model):
    __tablename__ = 'venda_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    local_entrega = db.Column(db.String(100))
    local_cobranca = db.Column(db.String(100))
    tipo_frete = db.Column(db.String(1))
    forma_pagamento = db.Column(db.String(1))
    data_venda = db.Column(db.DateTime)
    data_saida = db.Column(db.DateTime)
    hora_saida = db.Column(db.String(8))
    numero_fatura = db.Column(db.Integer)
    valor_frete = db.Column(db.Float)
    valor_seguro = db.Column(db.Float)
    valor_subtotal = db.Column(db.Float)
    taxa_comissao = db.Column(db.Float)
    valor_comissao = db.Column(db.Float)
    taxa_desconto = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    situacao = db.Column(db.String(1))
    dia_fixo_parcela = db.Column(db.String(2))
    observacao = db.Column(db.Text)
    id_venda_condicoes_pagamento = db.Column(db.Integer, db.ForeignKey('venda_condicoes_pagamento.id'))
    id_vendedor = db.Column(db.Integer, db.ForeignKey('view_pessoa_vendedor.id'))
    id_transportadora = db.Column(db.Integer, db.ForeignKey('view_pessoa_transportadora.id'))
    id_cliente = db.Column(db.Integer, db.ForeignKey('view_pessoa_cliente.id'))
    id_venda_orcamento_cabecalho = db.Column(db.Integer, db.ForeignKey('venda_orcamento_cabecalho.id'))
    id_nota_fiscal_tipo = db.Column(db.Integer, db.ForeignKey('nota_fiscal_tipo.id'))

    venda_comissao_model = db.relationship('VendaComissaoModel', uselist=False)
    venda_detalhe_model_list = db.relationship('VendaDetalheModel', lazy='dynamic')
    venda_frete_model_list = db.relationship('VendaFreteModel', lazy='dynamic')
    venda_condicoes_pagamento_model = db.relationship('VendaCondicoesPagamentoModel', foreign_keys=[id_venda_condicoes_pagamento])
    view_pessoa_vendedor_model = db.relationship('ViewPessoaVendedorModel', foreign_keys=[id_vendedor])
    view_pessoa_transportadora_model = db.relationship('ViewPessoaTransportadoraModel', foreign_keys=[id_transportadora])
    view_pessoa_cliente_model = db.relationship('ViewPessoaClienteModel', foreign_keys=[id_cliente])
    venda_orcamento_cabecalho_model = db.relationship('VendaOrcamentoCabecalhoModel', foreign_keys=[id_venda_orcamento_cabecalho])
    nota_fiscal_tipo_model = db.relationship('NotaFiscalTipoModel', foreign_keys=[id_nota_fiscal_tipo])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_venda_orcamento_cabecalho = data.get('idVendaOrcamentoCabecalho')
        self.id_nota_fiscal_tipo = data.get('idNotaFiscalTipo')
        self.id_vendedor = data.get('idVendedor')
        self.id_venda_condicoes_pagamento = data.get('idVendaCondicoesPagamento')
        self.id_transportadora = data.get('idTransportadora')
        self.id_cliente = data.get('idCliente')
        self.local_entrega = data.get('localEntrega')
        self.local_cobranca = data.get('localCobranca')
        self.tipo_frete = data.get('tipoFrete')
        self.forma_pagamento = data.get('formaPagamento')
        self.data_venda = data.get('dataVenda')
        self.data_saida = data.get('dataSaida')
        self.hora_saida = data.get('horaSaida')
        self.numero_fatura = data.get('numeroFatura')
        self.valor_frete = data.get('valorFrete')
        self.valor_seguro = data.get('valorSeguro')
        self.valor_subtotal = data.get('valorSubtotal')
        self.taxa_comissao = data.get('taxaComissao')
        self.valor_comissao = data.get('valorComissao')
        self.taxa_desconto = data.get('taxaDesconto')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_total = data.get('valorTotal')
        self.situacao = data.get('situacao')
        self.dia_fixo_parcela = data.get('diaFixoParcela')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idVendaOrcamentoCabecalho': self.id_venda_orcamento_cabecalho,
            'idNotaFiscalTipo': self.id_nota_fiscal_tipo,
            'idVendedor': self.id_vendedor,
            'idVendaCondicoesPagamento': self.id_venda_condicoes_pagamento,
            'idTransportadora': self.id_transportadora,
            'idCliente': self.id_cliente,
            'localEntrega': self.local_entrega,
            'localCobranca': self.local_cobranca,
            'tipoFrete': self.tipo_frete,
            'formaPagamento': self.forma_pagamento,
            'dataVenda': self.data_venda.isoformat(),
            'dataSaida': self.data_saida.isoformat(),
            'horaSaida': self.hora_saida,
            'numeroFatura': self.numero_fatura,
            'valorFrete': self.valor_frete,
            'valorSeguro': self.valor_seguro,
            'valorSubtotal': self.valor_subtotal,
            'taxaComissao': self.taxa_comissao,
            'valorComissao': self.valor_comissao,
            'taxaDesconto': self.taxa_desconto,
            'valorDesconto': self.valor_desconto,
            'valorTotal': self.valor_total,
            'situacao': self.situacao,
            'diaFixoParcela': self.dia_fixo_parcela,
            'observacao': self.observacao,
            'vendaComissaoModel': self.venda_comissao_model.serialize() if self.venda_comissao_model else None,
            'vendaDetalheModelList': [venda_detalhe_model.serialize() for venda_detalhe_model in self.venda_detalhe_model_list],
            'vendaFreteModelList': [venda_frete_model.serialize() for venda_frete_model in self.venda_frete_model_list],
            'vendaCondicoesPagamentoModel': self.venda_condicoes_pagamento_model.serialize() if self.venda_condicoes_pagamento_model else None,
            'viewPessoaVendedorModel': self.view_pessoa_vendedor_model.serialize() if self.view_pessoa_vendedor_model else None,
            'viewPessoaTransportadoraModel': self.view_pessoa_transportadora_model.serialize() if self.view_pessoa_transportadora_model else None,
            'viewPessoaClienteModel': self.view_pessoa_cliente_model.serialize() if self.view_pessoa_cliente_model else None,
            'vendaOrcamentoCabecalhoModel': self.venda_orcamento_cabecalho_model.serialize() if self.venda_orcamento_cabecalho_model else None,
            'notaFiscalTipoModel': self.nota_fiscal_tipo_model.serialize() if self.nota_fiscal_tipo_model else None,
        }