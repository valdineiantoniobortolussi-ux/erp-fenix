from src import db
from src.model.fin_natureza_financeira_model import FinNaturezaFinanceiraModel


class ProjetoCustoModel(db.Model):
    __tablename__ = 'projeto_custo'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    valor_mensal = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    justificativa = db.Column(db.Text)
    id_projeto_principal = db.Column(db.Integer, db.ForeignKey('projeto_principal.id'))
    id_fin_natureza_financeira = db.Column(db.Integer, db.ForeignKey('fin_natureza_financeira.id'))

    fin_natureza_financeira_model = db.relationship('FinNaturezaFinanceiraModel', foreign_keys=[id_fin_natureza_financeira])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_projeto_principal = data.get('idProjetoPrincipal')
        self.id_fin_natureza_financeira = data.get('idFinNaturezaFinanceira')
        self.nome = data.get('nome')
        self.valor_mensal = data.get('valorMensal')
        self.valor_total = data.get('valorTotal')
        self.justificativa = data.get('justificativa')

    def serialize(self):
        return {
            'id': self.id,
            'idProjetoPrincipal': self.id_projeto_principal,
            'idFinNaturezaFinanceira': self.id_fin_natureza_financeira,
            'nome': self.nome,
            'valorMensal': self.valor_mensal,
            'valorTotal': self.valor_total,
            'justificativa': self.justificativa,
            'finNaturezaFinanceiraModel': self.fin_natureza_financeira_model.serialize() if self.fin_natureza_financeira_model else None,
        }