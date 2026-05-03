from src import db
from src.model.fin_natureza_financeira_model import FinNaturezaFinanceiraModel


class CtResultadoNtFinanceiraModel(db.Model):
    __tablename__ = 'ct_resultado_nt_financeira'

    id = db.Column(db.Integer, primary_key=True)
    percentual_rateio = db.Column(db.Float)
    id_fin_natureza_financeira = db.Column(db.Integer, db.ForeignKey('fin_natureza_financeira.id'))
    id_centro_resultado = db.Column(db.Integer, db.ForeignKey('centro_resultado.id'))

    fin_natureza_financeira_model = db.relationship('FinNaturezaFinanceiraModel', foreign_keys=[id_fin_natureza_financeira])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_centro_resultado = data.get('idCentroResultado')
        self.id_fin_natureza_financeira = data.get('idFinNaturezaFinanceira')
        self.percentual_rateio = data.get('percentualRateio')

    def serialize(self):
        return {
            'id': self.id,
            'idCentroResultado': self.id_centro_resultado,
            'idFinNaturezaFinanceira': self.id_fin_natureza_financeira,
            'percentualRateio': self.percentual_rateio,
            'finNaturezaFinanceiraModel': self.fin_natureza_financeira_model.serialize() if self.fin_natureza_financeira_model else None,
        }