from src import db
from sqlalchemy import text
from src.model.nfe_numero_model import NfeNumeroModel

class NfeNumeroService:
    def get_list(self):
        return NfeNumeroModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeNumeroModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeNumeroModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeNumeroModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeNumeroModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeNumeroModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()