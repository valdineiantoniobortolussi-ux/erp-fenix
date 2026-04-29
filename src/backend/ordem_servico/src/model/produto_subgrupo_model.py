from src import db
from src.model.produto_model import ProdutoModel


class ProdutoSubgrupoModel(db.Model):
    __tablename__ = 'produto_subgrupo'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    descricao = db.Column(db.String(250))
    id_produto_grupo = db.Column(db.Integer, db.ForeignKey('produto_grupo.id'))

    produto_model_list = db.relationship('ProdutoModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.id_produto_grupo = data.get('idProdutoGrupo')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idProdutoGrupo': self.id_produto_grupo,
            'nome': self.nome,
            'descricao': self.descricao,
            'produtoModelList': [produto_model.serialize() for produto_model in self.produto_model_list],
        }