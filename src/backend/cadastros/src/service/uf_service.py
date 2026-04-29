from src import db
from sqlalchemy import text
from src.model.uf_model import UfModel

class UfService:
    def get_list(self):
        return UfModel.query.all()

    def get_list_filter(self, filter_obj):
        return UfModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return UfModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = UfModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = UfModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = UfModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()