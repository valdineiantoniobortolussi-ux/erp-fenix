from src import db
from src.model.fiscal_termo_model import FiscalTermoModel


class FiscalLivroModel(db.Model):
    __tablename__ = 'fiscal_livro'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))

    fiscal_termo_model_list = db.relationship('FiscalTermoModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'descricao': self.descricao,
            'fiscalTermoModelList': [fiscal_termo_model.serialize() for fiscal_termo_model in self.fiscal_termo_model_list],
        }