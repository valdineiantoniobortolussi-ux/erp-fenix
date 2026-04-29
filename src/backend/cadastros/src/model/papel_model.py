from src import db
from src.model.papel_funcao_model import PapelFuncaoModel
from src.model.usuario_model import UsuarioModel


class PapelModel(db.Model):
    __tablename__ = 'papel'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    descrica = db.Column(db.String(250))

    papel_funcao_model_list = db.relationship('PapelFuncaoModel', lazy='dynamic')
    usuario_model_list = db.relationship('UsuarioModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.descrica = data.get('descrica')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'descrica': self.descrica,
            'papelFuncaoModelList': [papel_funcao_model.serialize() for papel_funcao_model in self.papel_funcao_model_list],
            'usuarioModelList': [usuario_model.serialize() for usuario_model in self.usuario_model_list],
        }