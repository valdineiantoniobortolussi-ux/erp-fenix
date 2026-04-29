from src import db
from sqlalchemy import text
from src.model.inventario_ajuste_cab_model import InventarioAjusteCabModel
from src.model.inventario_ajuste_det_model import InventarioAjusteDetModel

class InventarioAjusteCabService:
    def get_list(self):
        return InventarioAjusteCabModel.query.all()

    def get_list_filter(self, filter_obj):
        return InventarioAjusteCabModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return InventarioAjusteCabModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = InventarioAjusteCabModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = InventarioAjusteCabModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = InventarioAjusteCabModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # inventarioAjusteDetModel
        children_data = data.get('inventarioAjusteDetModelList', []) 
        for child_data in children_data:
            child = InventarioAjusteDetModel()
            child.mapping(child_data)
            parent.inventario_ajuste_det_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # inventarioAjusteDetModel
        for child in parent.inventario_ajuste_det_model_list: 
            db.session.delete(child)

