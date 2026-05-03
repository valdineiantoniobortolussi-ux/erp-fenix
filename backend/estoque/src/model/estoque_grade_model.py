from src import db
from src.model.produto_model import ProdutoModel
from src.model.estoque_cor_model import EstoqueCorModel
from src.model.estoque_tamanho_model import EstoqueTamanhoModel
from src.model.estoque_sabor_model import EstoqueSaborModel
from src.model.estoque_marca_model import EstoqueMarcaModel


class EstoqueGradeModel(db.Model):
    __tablename__ = 'estoque_grade'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(50))
    quantidade = db.Column(db.Float)
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))
    id_estoque_cor = db.Column(db.Integer, db.ForeignKey('estoque_cor.id'))
    id_estoque_tamanho = db.Column(db.Integer, db.ForeignKey('estoque_tamanho.id'))
    id_estoque_sabor = db.Column(db.Integer, db.ForeignKey('estoque_sabor.id'))
    id_estoque_marca = db.Column(db.Integer, db.ForeignKey('estoque_marca.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])
    estoque_cor_model = db.relationship('EstoqueCorModel', foreign_keys=[id_estoque_cor])
    estoque_tamanho_model = db.relationship('EstoqueTamanhoModel', foreign_keys=[id_estoque_tamanho])
    estoque_sabor_model = db.relationship('EstoqueSaborModel', foreign_keys=[id_estoque_sabor])
    estoque_marca_model = db.relationship('EstoqueMarcaModel', foreign_keys=[id_estoque_marca])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_produto = data.get('idProduto')
        self.id_estoque_marca = data.get('idEstoqueMarca')
        self.id_estoque_sabor = data.get('idEstoqueSabor')
        self.id_estoque_tamanho = data.get('idEstoqueTamanho')
        self.id_estoque_cor = data.get('idEstoqueCor')
        self.codigo = data.get('codigo')
        self.quantidade = data.get('quantidade')

    def serialize(self):
        return {
            'id': self.id,
            'idProduto': self.id_produto,
            'idEstoqueMarca': self.id_estoque_marca,
            'idEstoqueSabor': self.id_estoque_sabor,
            'idEstoqueTamanho': self.id_estoque_tamanho,
            'idEstoqueCor': self.id_estoque_cor,
            'codigo': self.codigo,
            'quantidade': self.quantidade,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
            'estoqueCorModel': self.estoque_cor_model.serialize() if self.estoque_cor_model else None,
            'estoqueTamanhoModel': self.estoque_tamanho_model.serialize() if self.estoque_tamanho_model else None,
            'estoqueSaborModel': self.estoque_sabor_model.serialize() if self.estoque_sabor_model else None,
            'estoqueMarcaModel': self.estoque_marca_model.serialize() if self.estoque_marca_model else None,
        }