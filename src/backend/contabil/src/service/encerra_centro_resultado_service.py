from src import db
from sqlalchemy import text
from src.model.encerra_centro_resultado_model import EncerraCentroResultadoModel

class EncerraCentroResultadoService:
    def get_list(self):
        return EncerraCentroResultadoModel.query.all()

    def get_list_filter(self, filter_obj):
        return EncerraCentroResultadoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EncerraCentroResultadoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EncerraCentroResultadoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EncerraCentroResultadoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EncerraCentroResultadoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()