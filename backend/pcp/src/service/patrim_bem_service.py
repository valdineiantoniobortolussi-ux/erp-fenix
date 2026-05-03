from src import db
from sqlalchemy import text
from src.model.patrim_bem_model import PatrimBemModel

class PatrimBemService:
    def get_list(self):
        return PatrimBemModel.query.all()

    def get_list_filter(self, filter_obj):
        return PatrimBemModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PatrimBemModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PatrimBemModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PatrimBemModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PatrimBemModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()