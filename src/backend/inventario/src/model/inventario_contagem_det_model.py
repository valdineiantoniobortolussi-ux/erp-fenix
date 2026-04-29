from src import db
from src.model.produto_model import ProdutoModel


class InventarioContagemDetModel(db.Model):
    __tablename__ = 'inventario_contagem_det'

    id = db.Column(db.Integer, primary_key=True)
    contagem01 = db.Column(db.Float)
    contagem02 = db.Column(db.Float)
    contagem03 = db.Column(db.Float)
    fechado_contagem = db.Column(db.String(2))
    quantidade_sistema = db.Column(db.Float)
    acuracidade = db.Column(db.Float)
    divergencia = db.Column(db.Float)
    id_inventario_contagem_cab = db.Column(db.Integer, db.ForeignKey('inventario_contagem_cab.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_inventario_contagem_cab = data.get('idInventarioContagemCab')
        self.id_produto = data.get('idProduto')
        self.contagem01 = data.get('contagem01')
        self.contagem02 = data.get('contagem02')
        self.contagem03 = data.get('contagem03')
        self.fechado_contagem = data.get('fechadoContagem')
        self.quantidade_sistema = data.get('quantidadeSistema')
        self.acuracidade = data.get('acuracidade')
        self.divergencia = data.get('divergencia')

    def serialize(self):
        return {
            'id': self.id,
            'idInventarioContagemCab': self.id_inventario_contagem_cab,
            'idProduto': self.id_produto,
            'contagem01': self.contagem01,
            'contagem02': self.contagem02,
            'contagem03': self.contagem03,
            'fechadoContagem': self.fechado_contagem,
            'quantidadeSistema': self.quantidade_sistema,
            'acuracidade': self.acuracidade,
            'divergencia': self.divergencia,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }