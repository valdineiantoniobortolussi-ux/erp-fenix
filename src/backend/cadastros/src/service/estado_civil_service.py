from src import db
from sqlalchemy import text
from src.model.estado_civil_model import EstadoCivilModel

class EstadoCivilService:
    def get_list(self):
        return EstadoCivilModel.query.all()

    def get_list_filter(self, filter_obj):
        return EstadoCivilModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EstadoCivilModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EstadoCivilModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EstadoCivilModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EstadoCivilModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()