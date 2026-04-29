from src import db
from src.model.fin_status_parcela_model import FinStatusParcelaModel
from src.model.fin_tipo_pagamento_model import FinTipoPagamentoModel


class FinParcelaPagarModel(db.Model):
    __tablename__ = 'fin_parcela_pagar'

    id = db.Column(db.Integer, primary_key=True)
    numero_parcela = db.Column(db.Integer)
    data_emissao = db.Column(db.DateTime)
    data_vencimento = db.Column(db.DateTime)
    data_pagamento = db.Column(db.DateTime)
    desconto_ate = db.Column(db.DateTime)
    valor = db.Column(db.Float)
    taxa_juro = db.Column(db.Float)
    taxa_multa = db.Column(db.Float)
    taxa_desconto = db.Column(db.Float)
    valor_juro = db.Column(db.Float)
    valor_multa = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_pago = db.Column(db.Float)
    historico = db.Column(db.Text)
    id_fin_lancamento_pagar = db.Column(db.Integer, db.ForeignKey('fin_lancamento_pagar.id'))
    id_fin_status_parcela = db.Column(db.Integer, db.ForeignKey('fin_status_parcela.id'))
    id_fin_tipo_pagamento = db.Column(db.Integer, db.ForeignKey('fin_tipo_pagamento.id'))

    fin_status_parcela_model = db.relationship('FinStatusParcelaModel', foreign_keys=[id_fin_status_parcela])
    fin_tipo_pagamento_model = db.relationship('FinTipoPagamentoModel', foreign_keys=[id_fin_tipo_pagamento])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_fin_lancamento_pagar = data.get('idFinLancamentoPagar')
        self.id_fin_cheque_emitido = data.get('idFinChequeEmitido')
        self.id_fin_status_parcela = data.get('idFinStatusParcela')
        self.id_fin_tipo_pagamento = data.get('idFinTipoPagamento')
        self.numero_parcela = data.get('numeroParcela')
        self.data_emissao = data.get('dataEmissao')
        self.data_vencimento = data.get('dataVencimento')
        self.data_pagamento = data.get('dataPagamento')
        self.desconto_ate = data.get('descontoAte')
        self.valor = data.get('valor')
        self.taxa_juro = data.get('taxaJuro')
        self.taxa_multa = data.get('taxaMulta')
        self.taxa_desconto = data.get('taxaDesconto')
        self.valor_juro = data.get('valorJuro')
        self.valor_multa = data.get('valorMulta')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_pago = data.get('valorPago')
        self.historico = data.get('historico')

    def serialize(self):
        return {
            'id': self.id,
            'idFinLancamentoPagar': self.id_fin_lancamento_pagar,
            'idFinChequeEmitido': self.id_fin_cheque_emitido,
            'idFinStatusParcela': self.id_fin_status_parcela,
            'idFinTipoPagamento': self.id_fin_tipo_pagamento,
            'numeroParcela': self.numero_parcela,
            'dataEmissao': self.data_emissao.isoformat(),
            'dataVencimento': self.data_vencimento.isoformat(),
            'dataPagamento': self.data_pagamento.isoformat(),
            'descontoAte': self.desconto_ate.isoformat(),
            'valor': self.valor,
            'taxaJuro': self.taxa_juro,
            'taxaMulta': self.taxa_multa,
            'taxaDesconto': self.taxa_desconto,
            'valorJuro': self.valor_juro,
            'valorMulta': self.valor_multa,
            'valorDesconto': self.valor_desconto,
            'valorPago': self.valor_pago,
            'historico': self.historico,
            'finStatusParcelaModel': self.fin_status_parcela_model.serialize() if self.fin_status_parcela_model else None,
            'finTipoPagamentoModel': self.fin_tipo_pagamento_model.serialize() if self.fin_tipo_pagamento_model else None,
        }