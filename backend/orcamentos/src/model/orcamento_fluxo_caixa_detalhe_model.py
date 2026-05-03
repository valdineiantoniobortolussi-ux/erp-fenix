from src import db
from src.model.fin_natureza_financeira_model import FinNaturezaFinanceiraModel


class OrcamentoFluxoCaixaDetalheModel(db.Model):
    __tablename__ = 'orcamento_fluxo_caixa_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    periodo = db.Column(db.String(10))
    valor_orcado = db.Column(db.Float)
    valor_realizado = db.Column(db.Float)
    taxa_variacao = db.Column(db.Float)
    valor_variacao = db.Column(db.Float)
    id_orcamento_fluxo_caixa = db.Column(db.Integer, db.ForeignKey('orcamento_fluxo_caixa.id'))
    id_fin_natureza_financeira = db.Column(db.Integer, db.ForeignKey('fin_natureza_financeira.id'))

    fin_natureza_financeira_model = db.relationship('FinNaturezaFinanceiraModel', foreign_keys=[id_fin_natureza_financeira])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_orcamento_fluxo_caixa = data.get('idOrcamentoFluxoCaixa')
        self.id_fin_natureza_financeira = data.get('idFinNaturezaFinanceira')
        self.periodo = data.get('periodo')
        self.valor_orcado = data.get('valorOrcado')
        self.valor_realizado = data.get('valorRealizado')
        self.taxa_variacao = data.get('taxaVariacao')
        self.valor_variacao = data.get('valorVariacao')

    def serialize(self):
        return {
            'id': self.id,
            'idOrcamentoFluxoCaixa': self.id_orcamento_fluxo_caixa,
            'idFinNaturezaFinanceira': self.id_fin_natureza_financeira,
            'periodo': self.periodo,
            'valorOrcado': self.valor_orcado,
            'valorRealizado': self.valor_realizado,
            'taxaVariacao': self.taxa_variacao,
            'valorVariacao': self.valor_variacao,
            'finNaturezaFinanceiraModel': self.fin_natureza_financeira_model.serialize() if self.fin_natureza_financeira_model else None,
        }