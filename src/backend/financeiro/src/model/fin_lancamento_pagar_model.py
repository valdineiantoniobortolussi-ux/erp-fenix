from src import db
from src.model.fin_parcela_pagar_model import FinParcelaPagarModel
from src.model.fin_documento_origem_model import FinDocumentoOrigemModel
from src.model.banco_conta_caixa_model import BancoContaCaixaModel
from src.model.fin_natureza_financeira_model import FinNaturezaFinanceiraModel
from src.model.view_pessoa_fornecedor_model import ViewPessoaFornecedorModel


class FinLancamentoPagarModel(db.Model):
    __tablename__ = 'fin_lancamento_pagar'

    id = db.Column(db.Integer, primary_key=True)
    quantidade_parcela = db.Column(db.Integer)
    valor_a_pagar = db.Column(db.Float)
    data_lancamento = db.Column(db.DateTime)
    numero_documento = db.Column(db.String(50))
    primeiro_vencimento = db.Column(db.DateTime)
    intervalo_entre_parcelas = db.Column(db.Integer)
    dia_fixo = db.Column(db.String(2))
    imagem_documento = db.Column(db.Text)
    id_fin_documento_origem = db.Column(db.Integer, db.ForeignKey('fin_documento_origem.id'))
    id_banco_conta_caixa = db.Column(db.Integer, db.ForeignKey('banco_conta_caixa.id'))
    id_fin_natureza_financeira = db.Column(db.Integer, db.ForeignKey('fin_natureza_financeira.id'))
    id_fornecedor = db.Column(db.Integer, db.ForeignKey('view_pessoa_fornecedor.id'))

    fin_parcela_pagar_model_list = db.relationship('FinParcelaPagarModel', lazy='dynamic')
    fin_documento_origem_model = db.relationship('FinDocumentoOrigemModel', foreign_keys=[id_fin_documento_origem])
    banco_conta_caixa_model = db.relationship('BancoContaCaixaModel', foreign_keys=[id_banco_conta_caixa])
    fin_natureza_financeira_model = db.relationship('FinNaturezaFinanceiraModel', foreign_keys=[id_fin_natureza_financeira])
    view_pessoa_fornecedor_model = db.relationship('ViewPessoaFornecedorModel', foreign_keys=[id_fornecedor])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_fornecedor = data.get('idFornecedor')
        self.id_banco_conta_caixa = data.get('idBancoContaCaixa')
        self.id_fin_documento_origem = data.get('idFinDocumentoOrigem')
        self.id_fin_natureza_financeira = data.get('idFinNaturezaFinanceira')
        self.quantidade_parcela = data.get('quantidadeParcela')
        self.valor_a_pagar = data.get('valorAPagar')
        self.data_lancamento = data.get('dataLancamento')
        self.numero_documento = data.get('numeroDocumento')
        self.primeiro_vencimento = data.get('primeiroVencimento')
        self.intervalo_entre_parcelas = data.get('intervaloEntreParcelas')
        self.dia_fixo = data.get('diaFixo')
        self.imagem_documento = data.get('imagemDocumento')

    def serialize(self):
        return {
            'id': self.id,
            'idFornecedor': self.id_fornecedor,
            'idBancoContaCaixa': self.id_banco_conta_caixa,
            'idFinDocumentoOrigem': self.id_fin_documento_origem,
            'idFinNaturezaFinanceira': self.id_fin_natureza_financeira,
            'quantidadeParcela': self.quantidade_parcela,
            'valorAPagar': self.valor_a_pagar,
            'dataLancamento': self.data_lancamento.isoformat(),
            'numeroDocumento': self.numero_documento,
            'primeiroVencimento': self.primeiro_vencimento.isoformat(),
            'intervaloEntreParcelas': self.intervalo_entre_parcelas,
            'diaFixo': self.dia_fixo,
            'imagemDocumento': self.imagem_documento,
            'finParcelaPagarModelList': [fin_parcela_pagar_model.serialize() for fin_parcela_pagar_model in self.fin_parcela_pagar_model_list],
            'finDocumentoOrigemModel': self.fin_documento_origem_model.serialize() if self.fin_documento_origem_model else None,
            'bancoContaCaixaModel': self.banco_conta_caixa_model.serialize() if self.banco_conta_caixa_model else None,
            'finNaturezaFinanceiraModel': self.fin_natureza_financeira_model.serialize() if self.fin_natureza_financeira_model else None,
            'viewPessoaFornecedorModel': self.view_pessoa_fornecedor_model.serialize() if self.view_pessoa_fornecedor_model else None,
        }