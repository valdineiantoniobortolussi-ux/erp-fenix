from src import db
from sqlalchemy import text
from src.model.feriados_model import FeriadosModel

class FeriadosService:
    def get_list(self):
        return FeriadosModel.query.all()

    def get_list_filter(self, filter_obj):
        return FeriadosModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FeriadosModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FeriadosModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FeriadosModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FeriadosModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()