from src import db
from sqlalchemy import text
from src.model.inventario_contagem_cab_model import InventarioContagemCabModel
from src.model.inventario_contagem_det_model import InventarioContagemDetModel

class InventarioContagemCabService:
    def get_list(self):
        return InventarioContagemCabModel.query.all()

    def get_list_filter(self, filter_obj):
        return InventarioContagemCabModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return InventarioContagemCabModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = InventarioContagemCabModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = InventarioContagemCabModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = InventarioContagemCabModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # inventarioContagemDetModel
        children_data = data.get('inventarioContagemDetModelList', []) 
        for child_data in children_data:
            child = InventarioContagemDetModel()
            child.mapping(child_data)
            parent.inventario_contagem_det_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # inventarioContagemDetModel
        for child in parent.inventario_contagem_det_model_list: 
            db.session.delete(child)

