from src import db
from src.model.inventario_contagem_det_model import InventarioContagemDetModel


class InventarioContagemCabModel(db.Model):
    __tablename__ = 'inventario_contagem_cab'

    id = db.Column(db.Integer, primary_key=True)
    data_contagem = db.Column(db.DateTime)
    estoque_atualizado = db.Column(db.String(1))
    tipo = db.Column(db.String(1))

    inventario_contagem_det_model_list = db.relationship('InventarioContagemDetModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.data_contagem = data.get('dataContagem')
        self.estoque_atualizado = data.get('estoqueAtualizado')
        self.tipo = data.get('tipo')

    def serialize(self):
        return {
            'id': self.id,
            'dataContagem': self.data_contagem.isoformat(),
            'estoqueAtualizado': self.estoque_atualizado,
            'tipo': self.tipo,
            'inventarioContagemDetModelList': [inventario_contagem_det_model.serialize() for inventario_contagem_det_model in self.inventario_contagem_det_model_list],
        }