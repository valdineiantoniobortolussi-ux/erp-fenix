from src import db
from src.model.produto_model import ProdutoModel


class GondolaArmazenamentoModel(db.Model):
    __tablename__ = 'gondola_armazenamento'

    id = db.Column(db.Integer, primary_key=True)
    quantidade = db.Column(db.Integer)
    id_gondola_caixa = db.Column(db.Integer, db.ForeignKey('gondola_caixa.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_gondola_caixa = data.get('idGondolaCaixa')
        self.id_produto = data.get('idProduto')
        self.quantidade = data.get('quantidade')

    def serialize(self):
        return {
            'id': self.id,
            'idGondolaCaixa': self.id_gondola_caixa,
            'idProduto': self.id_produto,
            'quantidade': self.quantidade,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }