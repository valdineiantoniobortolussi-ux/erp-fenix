from src import db
from src.model.fin_parcela_receber_model import FinParcelaReceberModel
from src.model.fin_documento_origem_model import FinDocumentoOrigemModel
from src.model.banco_conta_caixa_model import BancoContaCaixaModel
from src.model.fin_natureza_financeira_model import FinNaturezaFinanceiraModel
from src.model.view_pessoa_cliente_model import ViewPessoaClienteModel


class FinLancamentoReceberModel(db.Model):
    __tablename__ = 'fin_lancamento_receber'

    id = db.Column(db.Integer, primary_key=True)
    quantidade_parcela = db.Column(db.Integer)
    valor_a_receber = db.Column(db.Float)
    data_lancamento = db.Column(db.DateTime)
    numero_documento = db.Column(db.String(50))
    primeiro_vencimento = db.Column(db.DateTime)
    taxa_comissao = db.Column(db.Float)
    valor_comissao = db.Column(db.Float)
    intervalo_entre_parcelas = db.Column(db.Integer)
    dia_fixo = db.Column(db.String(2))
    id_fin_documento_origem = db.Column(db.Integer, db.ForeignKey('fin_documento_origem.id'))
    id_banco_conta_caixa = db.Column(db.Integer, db.ForeignKey('banco_conta_caixa.id'))
    id_fin_natureza_financeira = db.Column(db.Integer, db.ForeignKey('fin_natureza_financeira.id'))
    id_cliente = db.Column(db.Integer, db.ForeignKey('view_pessoa_cliente.id'))

    fin_parcela_receber_model_list = db.relationship('FinParcelaReceberModel', lazy='dynamic')
    fin_documento_origem_model = db.relationship('FinDocumentoOrigemModel', foreign_keys=[id_fin_documento_origem])
    banco_conta_caixa_model = db.relationship('BancoContaCaixaModel', foreign_keys=[id_banco_conta_caixa])
    fin_natureza_financeira_model = db.relationship('FinNaturezaFinanceiraModel', foreign_keys=[id_fin_natureza_financeira])
    view_pessoa_cliente_model = db.relationship('ViewPessoaClienteModel', foreign_keys=[id_cliente])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cliente = data.get('idCliente')
        self.id_banco_conta_caixa = data.get('idBancoContaCaixa')
        self.id_fin_documento_origem = data.get('idFinDocumentoOrigem')
        self.id_fin_natureza_financeira = data.get('idFinNaturezaFinanceira')
        self.quantidade_parcela = data.get('quantidadeParcela')
        self.valor_a_receber = data.get('valorAReceber')
        self.data_lancamento = data.get('dataLancamento')
        self.numero_documento = data.get('numeroDocumento')
        self.primeiro_vencimento = data.get('primeiroVencimento')
        self.taxa_comissao = data.get('taxaComissao')
        self.valor_comissao = data.get('valorComissao')
        self.intervalo_entre_parcelas = data.get('intervaloEntreParcelas')
        self.dia_fixo = data.get('diaFixo')

    def serialize(self):
        return {
            'id': self.id,
            'idCliente': self.id_cliente,
            'idBancoContaCaixa': self.id_banco_conta_caixa,
            'idFinDocumentoOrigem': self.id_fin_documento_origem,
            'idFinNaturezaFinanceira': self.id_fin_natureza_financeira,
            'quantidadeParcela': self.quantidade_parcela,
            'valorAReceber': self.valor_a_receber,
            'dataLancamento': self.data_lancamento.isoformat(),
            'numeroDocumento': self.numero_documento,
            'primeiroVencimento': self.primeiro_vencimento.isoformat(),
            'taxaComissao': self.taxa_comissao,
            'valorComissao': self.valor_comissao,
            'intervaloEntreParcelas': self.intervalo_entre_parcelas,
            'diaFixo': self.dia_fixo,
            'finParcelaReceberModelList': [fin_parcela_receber_model.serialize() for fin_parcela_receber_model in self.fin_parcela_receber_model_list],
            'finDocumentoOrigemModel': self.fin_documento_origem_model.serialize() if self.fin_documento_origem_model else None,
            'bancoContaCaixaModel': self.banco_conta_caixa_model.serialize() if self.banco_conta_caixa_model else None,
            'finNaturezaFinanceiraModel': self.fin_natureza_financeira_model.serialize() if self.fin_natureza_financeira_model else None,
            'viewPessoaClienteModel': self.view_pessoa_cliente_model.serialize() if self.view_pessoa_cliente_model else None,
        }