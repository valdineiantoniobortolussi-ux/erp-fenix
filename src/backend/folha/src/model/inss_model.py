from src import db
from src.model.salario_familia_model import SalarioFamiliaModel
from src.model.inss_detalhe_model import InssDetalheModel


class InssModel(db.Model):
    __tablename__ = 'inss'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))

    salario_familia_model_list = db.relationship('SalarioFamiliaModel', lazy='dynamic')
    inss_detalhe_model_list = db.relationship('InssDetalheModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.competencia = data.get('competencia')

    def serialize(self):
        return {
            'id': self.id,
            'competencia': self.competencia,
            'salarioFamiliaModelList': [salario_familia_model.serialize() for salario_familia_model in self.salario_familia_model_list],
            'inssDetalheModelList': [inss_detalhe_model.serialize() for inss_detalhe_model in self.inss_detalhe_model_list],
        }