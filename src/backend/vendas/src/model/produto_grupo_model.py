from src import db
from src.model.produto_subgrupo_model import ProdutoSubgrupoModel


class ProdutoGrupoModel(db.Model):
    __tablename__ = 'produto_grupo'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    descricao = db.Column(db.String(250))

    produto_subgrupo_model_list = db.relationship('ProdutoSubgrupoModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'descricao': self.descricao,
            'produtoSubgrupoModelList': [produto_subgrupo_model.serialize() for produto_subgrupo_model in self.produto_subgrupo_model_list],
        }