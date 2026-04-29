from src import db
from src.model.produto_model import ProdutoModel


class InventarioAjusteDetModel(db.Model):
    __tablename__ = 'inventario_ajuste_det'

    id = db.Column(db.Integer, primary_key=True)
    valor_original = db.Column(db.Float)
    valor_reajuste = db.Column(db.Float)
    id_inventario_ajuste_cab = db.Column(db.Integer, db.ForeignKey('inventario_ajuste_cab.id'))
    id_produto = db.Column(db.Integer, db.ForeignKey('produto.id'))

    produto_model = db.relationship('ProdutoModel', foreign_keys=[id_produto])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_inventario_ajuste_cab = data.get('idInventarioAjusteCab')
        self.id_produto = data.get('idProduto')
        self.valor_original = data.get('valorOriginal')
        self.valor_reajuste = data.get('valorReajuste')

    def serialize(self):
        return {
            'id': self.id,
            'idInventarioAjusteCab': self.id_inventario_ajuste_cab,
            'idProduto': self.id_produto,
            'valorOriginal': self.valor_original,
            'valorReajuste': self.valor_reajuste,
            'produtoModel': self.produto_model.serialize() if self.produto_model else None,
        }