from src import db
from sqlalchemy import text
from src.model.cbo_model import CboModel

class CboService:
    def get_list(self):
        return CboModel.query.all()

    def get_list_filter(self, filter_obj):
        return CboModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CboModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CboModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CboModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CboModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()