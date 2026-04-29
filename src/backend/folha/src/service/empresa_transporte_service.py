from src import db
from sqlalchemy import text
from src.model.empresa_transporte_model import EmpresaTransporteModel
from src.model.empresa_transporte_itinerario_model import EmpresaTransporteItinerarioModel

class EmpresaTransporteService:
    def get_list(self):
        return EmpresaTransporteModel.query.all()

    def get_list_filter(self, filter_obj):
        return EmpresaTransporteModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EmpresaTransporteModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EmpresaTransporteModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EmpresaTransporteModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EmpresaTransporteModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # empresaTransporteItinerarioModel
        children_data = data.get('empresaTransporteItinerarioModelList', []) 
        for child_data in children_data:
            child = EmpresaTransporteItinerarioModel()
            child.mapping(child_data)
            parent.empresa_transporte_itinerario_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # empresaTransporteItinerarioModel
        for child in parent.empresa_transporte_itinerario_model_list: 
            db.session.delete(child)

