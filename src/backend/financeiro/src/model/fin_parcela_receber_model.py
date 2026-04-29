from src import db
from src.model.fin_status_parcela_model import FinStatusParcelaModel
from src.model.fin_tipo_recebimento_model import FinTipoRecebimentoModel


class FinParcelaReceberModel(db.Model):
    __tablename__ = 'fin_parcela_receber'

    id = db.Column(db.Integer, primary_key=True)
    numero_parcela = db.Column(db.Integer)
    data_emissao = db.Column(db.DateTime)
    data_vencimento = db.Column(db.DateTime)
    data_recebimento = db.Column(db.DateTime)
    desconto_ate = db.Column(db.DateTime)
    valor = db.Column(db.Float)
    taxa_juro = db.Column(db.Float)
    taxa_multa = db.Column(db.Float)
    taxa_desconto = db.Column(db.Float)
    valor_juro = db.Column(db.Float)
    valor_multa = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    emitiu_boleto = db.Column(db.String(1))
    boleto_nosso_numero = db.Column(db.String(50))
    valor_recebido = db.Column(db.Float)
    historico = db.Column(db.Text)
    id_fin_lancamento_receber = db.Column(db.Integer, db.ForeignKey('fin_lancamento_receber.id'))
    id_fin_status_parcela = db.Column(db.Integer, db.ForeignKey('fin_status_parcela.id'))
    id_fin_tipo_recebimento = db.Column(db.Integer, db.ForeignKey('fin_tipo_recebimento.id'))

    fin_status_parcela_model = db.relationship('FinStatusParcelaModel', foreign_keys=[id_fin_status_parcela])
    fin_tipo_recebimento_model = db.relationship('FinTipoRecebimentoModel', foreign_keys=[id_fin_tipo_recebimento])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_fin_lancamento_receber = data.get('idFinLancamentoReceber')
        self.id_fin_cheque_recebido = data.get('idFinChequeRecebido')
        self.id_fin_status_parcela = data.get('idFinStatusParcela')
        self.id_fin_tipo_recebimento = data.get('idFinTipoRecebimento')
        self.numero_parcela = data.get('numeroParcela')
        self.data_emissao = data.get('dataEmissao')
        self.data_vencimento = data.get('dataVencimento')
        self.data_recebimento = data.get('dataRecebimento')
        self.desconto_ate = data.get('descontoAte')
        self.valor = data.get('valor')
        self.taxa_juro = data.get('taxaJuro')
        self.taxa_multa = data.get('taxaMulta')
        self.taxa_desconto = data.get('taxaDesconto')
        self.valor_juro = data.get('valorJuro')
        self.valor_multa = data.get('valorMulta')
        self.valor_desconto = data.get('valorDesconto')
        self.emitiu_boleto = data.get('emitiuBoleto')
        self.boleto_nosso_numero = data.get('boletoNossoNumero')
        self.valor_recebido = data.get('valorRecebido')
        self.historico = data.get('historico')

    def serialize(self):
        return {
            'id': self.id,
            'idFinLancamentoReceber': self.id_fin_lancamento_receber,
            'idFinChequeRecebido': self.id_fin_cheque_recebido,
            'idFinStatusParcela': self.id_fin_status_parcela,
            'idFinTipoRecebimento': self.id_fin_tipo_recebimento,
            'numeroParcela': self.numero_parcela,
            'dataEmissao': self.data_emissao.isoformat(),
            'dataVencimento': self.data_vencimento.isoformat(),
            'dataRecebimento': self.data_recebimento.isoformat(),
            'descontoAte': self.desconto_ate.isoformat(),
            'valor': self.valor,
            'taxaJuro': self.taxa_juro,
            'taxaMulta': self.taxa_multa,
            'taxaDesconto': self.taxa_desconto,
            'valorJuro': self.valor_juro,
            'valorMulta': self.valor_multa,
            'valorDesconto': self.valor_desconto,
            'emitiuBoleto': self.emitiu_boleto,
            'boletoNossoNumero': self.boleto_nosso_numero,
            'valorRecebido': self.valor_recebido,
            'historico': self.historico,
            'finStatusParcelaModel': self.fin_status_parcela_model.serialize() if self.fin_status_parcela_model else None,
            'finTipoRecebimentoModel': self.fin_tipo_recebimento_model.serialize() if self.fin_tipo_recebimento_model else None,
        }