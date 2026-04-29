from src import db
from src.model.produto_grupo_model import ProdutoGrupoModel


class ProdutoSubgrupoModel(db.Model):
    __tablename__ = 'produto_subgrupo'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    descricao = db.Column(db.String(250))
    id_produto_grupo = db.Column(db.Integer, db.ForeignKey('produto_grupo.id'))

    produto_grupo_model = db.relationship('ProdutoGrupoModel', foreign_keys=[id_produto_grupo])

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
            'produtoGrupoModel': self.produto_grupo_model.serialize() if self.produto_grupo_model else None,
        }