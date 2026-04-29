from src import db
from src.model.banco_conta_caixa_model import BancoContaCaixaModel


class FinExtratoContaBancoModel(db.Model):
    __tablename__ = 'fin_extrato_conta_banco'

    id = db.Column(db.Integer, primary_key=True)
    mes_ano = db.Column(db.String(7))
    mes = db.Column(db.String(2))
    ano = db.Column(db.String(4))
    data_movimento = db.Column(db.DateTime)
    data_balancete = db.Column(db.DateTime)
    historico = db.Column(db.String(250))
    documento = db.Column(db.String(50))
    valor = db.Column(db.Float)
    conciliado = db.Column(db.String(1))
    observacao = db.Column(db.Text)
    id_banco_conta_caixa = db.Column(db.Integer, db.ForeignKey('banco_conta_caixa.id'))

    banco_conta_caixa_model = db.relationship('BancoContaCaixaModel', foreign_keys=[id_banco_conta_caixa])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_banco_conta_caixa = data.get('idBancoContaCaixa')
        self.mes_ano = data.get('mesAno')
        self.mes = data.get('mes')
        self.ano = data.get('ano')
        self.data_movimento = data.get('dataMovimento')
        self.data_balancete = data.get('dataBalancete')
        self.historico = data.get('historico')
        self.documento = data.get('documento')
        self.valor = data.get('valor')
        self.conciliado = data.get('conciliado')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idBancoContaCaixa': self.id_banco_conta_caixa,
            'mesAno': self.mes_ano,
            'mes': self.mes,
            'ano': self.ano,
            'dataMovimento': self.data_movimento.isoformat(),
            'dataBalancete': self.data_balancete.isoformat(),
            'historico': self.historico,
            'documento': self.documento,
            'valor': self.valor,
            'conciliado': self.conciliado,
            'observacao': self.observacao,
            'bancoContaCaixaModel': self.banco_conta_caixa_model.serialize() if self.banco_conta_caixa_model else None,
        }