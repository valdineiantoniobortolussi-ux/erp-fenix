from src import db
from src.model.produto_model import ProdutoModel


class ProdutoUnidadeModel(db.Model):
    __tablename__ = 'produto_unidade'

    id = db.Column(db.Integer, primary_key=True)
    sigla = db.Column(db.String(10))
    descricao = db.Column(db.String(250))
    pode_fracionar = db.Column(db.String(1))

    produto_model_list = db.relationship('ProdutoModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.sigla = data.get('sigla')
        self.descricao = data.get('descricao')
        self.pode_fracionar = data.get('podeFracionar')

    def serialize(self):
        return {
            'id': self.id,
            'sigla': self.sigla,
            'descricao': self.descricao,
            'podeFracionar': self.pode_fracionar,
            'produtoModelList': [produto_model.serialize() for produto_model in self.produto_model_list],
        }