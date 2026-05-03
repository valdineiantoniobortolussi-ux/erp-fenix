from src import db
from sqlalchemy import text
from src.model.ponto_relogio_model import PontoRelogioModel

class PontoRelogioService:
    def get_list(self):
        return PontoRelogioModel.query.all()

    def get_list_filter(self, filter_obj):
        return PontoRelogioModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PontoRelogioModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PontoRelogioModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PontoRelogioModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PontoRelogioModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()