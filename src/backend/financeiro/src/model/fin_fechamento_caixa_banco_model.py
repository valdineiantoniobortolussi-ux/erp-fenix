from src import db
from src.model.banco_conta_caixa_model import BancoContaCaixaModel


class FinFechamentoCaixaBancoModel(db.Model):
    __tablename__ = 'fin_fechamento_caixa_banco'

    id = db.Column(db.Integer, primary_key=True)
    data_fechamento = db.Column(db.DateTime)
    mes_ano = db.Column(db.String(7))
    mes = db.Column(db.String(2))
    ano = db.Column(db.String(4))
    saldo_anterior = db.Column(db.Float)
    recebimentos = db.Column(db.Float)
    pagamentos = db.Column(db.Float)
    saldo_conta = db.Column(db.Float)
    cheque_nao_compensado = db.Column(db.Float)
    saldo_disponivel = db.Column(db.Float)
    id_banco_conta_caixa = db.Column(db.Integer, db.ForeignKey('banco_conta_caixa.id'))

    banco_conta_caixa_model = db.relationship('BancoContaCaixaModel', foreign_keys=[id_banco_conta_caixa])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_banco_conta_caixa = data.get('idBancoContaCaixa')
        self.data_fechamento = data.get('dataFechamento')
        self.mes_ano = data.get('mesAno')
        self.mes = data.get('mes')
        self.ano = data.get('ano')
        self.saldo_anterior = data.get('saldoAnterior')
        self.recebimentos = data.get('recebimentos')
        self.pagamentos = data.get('pagamentos')
        self.saldo_conta = data.get('saldoConta')
        self.cheque_nao_compensado = data.get('chequeNaoCompensado')
        self.saldo_disponivel = data.get('saldoDisponivel')

    def serialize(self):
        return {
            'id': self.id,
            'idBancoContaCaixa': self.id_banco_conta_caixa,
            'dataFechamento': self.data_fechamento.isoformat(),
            'mesAno': self.mes_ano,
            'mes': self.mes,
            'ano': self.ano,
            'saldoAnterior': self.saldo_anterior,
            'recebimentos': self.recebimentos,
            'pagamentos': self.pagamentos,
            'saldoConta': self.saldo_conta,
            'chequeNaoCompensado': self.cheque_nao_compensado,
            'saldoDisponivel': self.saldo_disponivel,
            'bancoContaCaixaModel': self.banco_conta_caixa_model.serialize() if self.banco_conta_caixa_model else None,
        }