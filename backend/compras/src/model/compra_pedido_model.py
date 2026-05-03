from src import db
from src.model.compra_pedido_detalhe_model import CompraPedidoDetalheModel
from src.model.compra_tipo_pedido_model import CompraTipoPedidoModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.view_pessoa_fornecedor_model import ViewPessoaFornecedorModel


class CompraPedidoModel(db.Model):
    __tablename__ = 'compra_pedido'

    id = db.Column(db.Integer, primary_key=True)
    codigo_cotacao = db.Column(db.String(32))
    data_pedido = db.Column(db.DateTime)
    data_prevista_entrega = db.Column(db.DateTime)
    data_previsao_pagamento = db.Column(db.DateTime)
    local_entrega = db.Column(db.String(100))
    local_cobranca = db.Column(db.String(100))
    contato = db.Column(db.String(50))
    valor_subtotal = db.Column(db.Float)
    taxa_desconto = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    tipo_frete = db.Column(db.String(1))
    forma_pagamento = db.Column(db.String(1))
    base_calculo_icms = db.Column(db.Float)
    valor_icms = db.Column(db.Float)
    base_calculo_icms_st = db.Column(db.Float)
    valor_icms_st = db.Column(db.Float)
    valor_total_produtos = db.Column(db.Float)
    valor_frete = db.Column(db.Float)
    valor_seguro = db.Column(db.Float)
    valor_outras_despesas = db.Column(db.Float)
    valor_ipi = db.Column(db.Float)
    valor_total_nf = db.Column(db.Float)
    quantidade_parcelas = db.Column(db.Integer)
    dia_primeiro_vencimento = db.Column(db.String(2))
    intervalo_entre_parcelas = db.Column(db.Integer)
    dia_fixo_parcela = db.Column(db.String(2))
    id_compra_tipo_pedido = db.Column(db.Integer, db.ForeignKey('compra_tipo_pedido.id'))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))
    id_fornecedor = db.Column(db.Integer, db.ForeignKey('view_pessoa_fornecedor.id'))

    compra_pedido_detalhe_model_list = db.relationship('CompraPedidoDetalheModel', lazy='dynamic')
    compra_tipo_pedido_model = db.relationship('CompraTipoPedidoModel', foreign_keys=[id_compra_tipo_pedido])
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])
    view_pessoa_fornecedor_model = db.relationship('ViewPessoaFornecedorModel', foreign_keys=[id_fornecedor])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_compra_tipo_pedido = data.get('idCompraTipoPedido')
        self.id_colaborador = data.get('idColaborador')
        self.id_fornecedor = data.get('idFornecedor')
        self.codigo_cotacao = data.get('codigoCotacao')
        self.data_pedido = data.get('dataPedido')
        self.data_prevista_entrega = data.get('dataPrevistaEntrega')
        self.data_previsao_pagamento = data.get('dataPrevisaoPagamento')
        self.local_entrega = data.get('localEntrega')
        self.local_cobranca = data.get('localCobranca')
        self.contato = data.get('contato')
        self.valor_subtotal = data.get('valorSubtotal')
        self.taxa_desconto = data.get('taxaDesconto')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_total = data.get('valorTotal')
        self.tipo_frete = data.get('tipoFrete')
        self.forma_pagamento = data.get('formaPagamento')
        self.base_calculo_icms = data.get('baseCalculoIcms')
        self.valor_icms = data.get('valorIcms')
        self.base_calculo_icms_st = data.get('baseCalculoIcmsSt')
        self.valor_icms_st = data.get('valorIcmsSt')
        self.valor_total_produtos = data.get('valorTotalProdutos')
        self.valor_frete = data.get('valorFrete')
        self.valor_seguro = data.get('valorSeguro')
        self.valor_outras_despesas = data.get('valorOutrasDespesas')
        self.valor_ipi = data.get('valorIpi')
        self.valor_total_nf = data.get('valorTotalNf')
        self.quantidade_parcelas = data.get('quantidadeParcelas')
        self.dia_primeiro_vencimento = data.get('diaPrimeiroVencimento')
        self.intervalo_entre_parcelas = data.get('intervaloEntreParcelas')
        self.dia_fixo_parcela = data.get('diaFixoParcela')

    def serialize(self):
        return {
            'id': self.id,
            'idCompraTipoPedido': self.id_compra_tipo_pedido,
            'idColaborador': self.id_colaborador,
            'idFornecedor': self.id_fornecedor,
            'codigoCotacao': self.codigo_cotacao,
            'dataPedido': self.data_pedido.isoformat(),
            'dataPrevistaEntrega': self.data_prevista_entrega.isoformat(),
            'dataPrevisaoPagamento': self.data_previsao_pagamento.isoformat(),
            'localEntrega': self.local_entrega,
            'localCobranca': self.local_cobranca,
            'contato': self.contato,
            'valorSubtotal': self.valor_subtotal,
            'taxaDesconto': self.taxa_desconto,
            'valorDesconto': self.valor_desconto,
            'valorTotal': self.valor_total,
            'tipoFrete': self.tipo_frete,
            'formaPagamento': self.forma_pagamento,
            'baseCalculoIcms': self.base_calculo_icms,
            'valorIcms': self.valor_icms,
            'baseCalculoIcmsSt': self.base_calculo_icms_st,
            'valorIcmsSt': self.valor_icms_st,
            'valorTotalProdutos': self.valor_total_produtos,
            'valorFrete': self.valor_frete,
            'valorSeguro': self.valor_seguro,
            'valorOutrasDespesas': self.valor_outras_despesas,
            'valorIpi': self.valor_ipi,
            'valorTotalNf': self.valor_total_nf,
            'quantidadeParcelas': self.quantidade_parcelas,
            'diaPrimeiroVencimento': self.dia_primeiro_vencimento,
            'intervaloEntreParcelas': self.intervalo_entre_parcelas,
            'diaFixoParcela': self.dia_fixo_parcela,
            'compraPedidoDetalheModelList': [compra_pedido_detalhe_model.serialize() for compra_pedido_detalhe_model in self.compra_pedido_detalhe_model_list],
            'compraTipoPedidoModel': self.compra_tipo_pedido_model.serialize() if self.compra_tipo_pedido_model else None,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'viewPessoaFornecedorModel': self.view_pessoa_fornecedor_model.serialize() if self.view_pessoa_fornecedor_model else None,
        }