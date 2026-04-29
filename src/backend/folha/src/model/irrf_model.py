from src import db
from src.model.irrf_detalhe_model import IrrfDetalheModel


class IrrfModel(db.Model):
    __tablename__ = 'irrf'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))
    desconto_por_dependente = db.Column(db.Float)
    minimo_para_retencao = db.Column(db.Float)

    irrf_detalhe_model_list = db.relationship('IrrfDetalheModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.competencia = data.get('competencia')
        self.desconto_por_dependente = data.get('descontoPorDependente')
        self.minimo_para_retencao = data.get('minimoParaRetencao')

    def serialize(self):
        return {
            'id': self.id,
            'competencia': self.competencia,
            'descontoPorDependente': self.desconto_por_dependente,
            'minimoParaRetencao': self.minimo_para_retencao,
            'irrfDetalheModelList': [irrf_detalhe_model.serialize() for irrf_detalhe_model in self.irrf_detalhe_model_list],
        }