from src import db
from src.model.papel_funcao_model import PapelFuncaoModel


class FuncaoModel(db.Model):
    __tablename__ = 'funcao'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    descricao = db.Column(db.String(250))

    papel_funcao_model_list = db.relationship('PapelFuncaoModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'descricao': self.descricao,
            'papelFuncaoModelList': [papel_funcao_model.serialize() for papel_funcao_model in self.papel_funcao_model_list],
        }