from src import db
from src.model.plano_centro_resultado_model import PlanoCentroResultadoModel
from src.model.ct_resultado_nt_financeira_model import CtResultadoNtFinanceiraModel


class CentroResultadoModel(db.Model):
    __tablename__ = 'centro_resultado'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))
    classificacao = db.Column(db.String(30))
    sofre_rateiro = db.Column(db.String(1))
    id_plano_centro_resultado = db.Column(db.Integer, db.ForeignKey('plano_centro_resultado.id'))

    plano_centro_resultado_model = db.relationship('PlanoCentroResultadoModel', foreign_keys=[id_plano_centro_resultado])
    ct_resultado_nt_financeira_model_list = db.relationship('CtResultadoNtFinanceiraModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.id_plano_centro_resultado = data.get('idPlanoCentroResultado')
        self.descricao = data.get('descricao')
        self.classificacao = data.get('classificacao')
        self.sofre_rateiro = data.get('sofreRateiro')

    def serialize(self):
        return {
            'id': self.id,
            'idPlanoCentroResultado': self.id_plano_centro_resultado,
            'descricao': self.descricao,
            'classificacao': self.classificacao,
            'sofreRateiro': self.sofre_rateiro,
            'planoCentroResultadoModel': self.plano_centro_resultado_model.serialize() if self.plano_centro_resultado_model else None,
            'ctResultadoNtFinanceiraModelList': [ct_resultado_nt_financeira_model.serialize() for ct_resultado_nt_financeira_model in self.ct_resultado_nt_financeira_model_list],
        }