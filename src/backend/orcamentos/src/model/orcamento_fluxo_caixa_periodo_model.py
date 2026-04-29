from src import db
from src.model.banco_conta_caixa_model import BancoContaCaixaModel


class OrcamentoFluxoCaixaPeriodoModel(db.Model):
    __tablename__ = 'orcamento_fluxo_caixa_periodo'

    id = db.Column(db.Integer, primary_key=True)
    periodo = db.Column(db.String(1))
    nome = db.Column(db.String(30))
    id_banco_conta_caixa = db.Column(db.Integer, db.ForeignKey('banco_conta_caixa.id'))

    banco_conta_caixa_model = db.relationship('BancoContaCaixaModel', foreign_keys=[id_banco_conta_caixa])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_banco_conta_caixa = data.get('idBancoContaCaixa')
        self.periodo = data.get('periodo')
        self.nome = data.get('nome')

    def serialize(self):
        return {
            'id': self.id,
            'idBancoContaCaixa': self.id_banco_conta_caixa,
            'periodo': self.periodo,
            'nome': self.nome,
            'bancoContaCaixaModel': self.banco_conta_caixa_model.serialize() if self.banco_conta_caixa_model else None,
        }