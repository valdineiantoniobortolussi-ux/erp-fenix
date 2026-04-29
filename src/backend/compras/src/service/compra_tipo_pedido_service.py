from src import db
from sqlalchemy import text
from src.model.compra_tipo_pedido_model import CompraTipoPedidoModel

class CompraTipoPedidoService:
    def get_list(self):
        return CompraTipoPedidoModel.query.all()

    def get_list_filter(self, filter_obj):
        return CompraTipoPedidoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CompraTipoPedidoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CompraTipoPedidoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CompraTipoPedidoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CompraTipoPedidoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()