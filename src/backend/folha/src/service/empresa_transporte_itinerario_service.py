from src import db
from sqlalchemy import text
from src.model.empresa_transporte_itinerario_model import EmpresaTransporteItinerarioModel

class EmpresaTransporteItinerarioService:
    def get_list(self):
        return EmpresaTransporteItinerarioModel.query.all()

    def get_list_filter(self, filter_obj):
        return EmpresaTransporteItinerarioModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EmpresaTransporteItinerarioModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EmpresaTransporteItinerarioModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EmpresaTransporteItinerarioModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EmpresaTransporteItinerarioModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()