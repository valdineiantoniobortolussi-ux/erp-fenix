from src import db
from sqlalchemy import text
from src.model.compra_pedido_model import CompraPedidoModel
from src.model.compra_pedido_detalhe_model import CompraPedidoDetalheModel

class CompraPedidoService:
    def get_list(self):
        return CompraPedidoModel.query.all()

    def get_list_filter(self, filter_obj):
        return CompraPedidoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CompraPedidoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CompraPedidoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CompraPedidoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CompraPedidoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # compraPedidoDetalheModel
        children_data = data.get('compraPedidoDetalheModelList', []) 
        for child_data in children_data:
            child = CompraPedidoDetalheModel()
            child.mapping(child_data)
            parent.compra_pedido_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # compraPedidoDetalheModel
        for child in parent.compra_pedido_detalhe_model_list: 
            db.session.delete(child)

