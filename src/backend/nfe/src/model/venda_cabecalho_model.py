from src import db


class VendaCabecalhoModel(db.Model):
    __tablename__ = 'venda_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    id_venda_orcamento_cabecalho = db.Column(db.Integer)
    id_venda_condicoes_pagamento = db.Column(db.Integer)
    id_nota_fiscal_tipo = db.Column(db.Integer)
    id_transportadora = db.Column(db.Integer)
    data_venda = db.Column(db.DateTime)
    data_saida = db.Column(db.DateTime)
    hora_saida = db.Column(db.String(8))
    numero_fatura = db.Column(db.Integer)
    local_entrega = db.Column(db.String(100))
    local_cobranca = db.Column(db.String(100))
    valor_subtotal = db.Column(db.Float)
    taxa_comissao = db.Column(db.Float)
    valor_comissao = db.Column(db.Float)
    taxa_desconto = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    tipo_frete = db.Column(db.String(1))
    forma_pagamento = db.Column(db.String(1))
    valor_frete = db.Column(db.Float)
    valor_seguro = db.Column(db.Float)
    observacao = db.Column(db.Text)
    situacao = db.Column(db.String(1))
    dia_fixo_parcela = db.Column(db.String(2))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_venda_orcamento_cabecalho = data.get('idVendaOrcamentoCabecalho')
        self.id_venda_condicoes_pagamento = data.get('idVendaCondicoesPagamento')
        self.id_nota_fiscal_tipo = data.get('idNotaFiscalTipo')
        self.id_transportadora = data.get('idTransportadora')
        self.data_venda = data.get('dataVenda')
        self.data_saida = data.get('dataSaida')
        self.hora_saida = data.get('horaSaida')
        self.numero_fatura = data.get('numeroFatura')
        self.local_entrega = data.get('localEntrega')
        self.local_cobranca = data.get('localCobranca')
        self.valor_subtotal = data.get('valorSubtotal')
        self.taxa_comissao = data.get('taxaComissao')
        self.valor_comissao = data.get('valorComissao')
        self.taxa_desconto = data.get('taxaDesconto')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_total = data.get('valorTotal')
        self.tipo_frete = data.get('tipoFrete')
        self.forma_pagamento = data.get('formaPagamento')
        self.valor_frete = data.get('valorFrete')
        self.valor_seguro = data.get('valorSeguro')
        self.observacao = data.get('observacao')
        self.situacao = data.get('situacao')
        self.dia_fixo_parcela = data.get('diaFixoParcela')

    def serialize(self):
        return {
            'id': self.id,
            'idVendaOrcamentoCabecalho': self.id_venda_orcamento_cabecalho,
            'idVendaCondicoesPagamento': self.id_venda_condicoes_pagamento,
            'idNotaFiscalTipo': self.id_nota_fiscal_tipo,
            'idTransportadora': self.id_transportadora,
            'dataVenda': self.data_venda.isoformat(),
            'dataSaida': self.data_saida.isoformat(),
            'horaSaida': self.hora_saida,
            'numeroFatura': self.numero_fatura,
            'localEntrega': self.local_entrega,
            'localCobranca': self.local_cobranca,
            'valorSubtotal': self.valor_subtotal,
            'taxaComissao': self.taxa_comissao,
            'valorComissao': self.valor_comissao,
            'taxaDesconto': self.taxa_desconto,
            'valorDesconto': self.valor_desconto,
            'valorTotal': self.valor_total,
            'tipoFrete': self.tipo_frete,
            'formaPagamento': self.forma_pagamento,
            'valorFrete': self.valor_frete,
            'valorSeguro': self.valor_seguro,
            'observacao': self.observacao,
            'situacao': self.situacao,
            'diaFixoParcela': self.dia_fixo_parcela,
        }