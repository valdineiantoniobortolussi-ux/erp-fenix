from src import db
from src.model.folha_inss_retencao_model import FolhaInssRetencaoModel


class FolhaInssModel(db.Model):
    __tablename__ = 'folha_inss'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))

    folha_inss_retencao_model_list = db.relationship('FolhaInssRetencaoModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.competencia = data.get('competencia')

    def serialize(self):
        return {
            'id': self.id,
            'competencia': self.competencia,
            'folhaInssRetencaoModelList': [folha_inss_retencao_model.serialize() for folha_inss_retencao_model in self.folha_inss_retencao_model_list],
        }