from src import db
from sqlalchemy import text
from src.model.centro_resultado_model import CentroResultadoModel

class CentroResultadoService:
    def get_list(self):
        return CentroResultadoModel.query.all()

    def get_list_filter(self, filter_obj):
        return CentroResultadoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CentroResultadoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CentroResultadoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CentroResultadoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CentroResultadoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()