from src import db
from sqlalchemy import text
from src.model.pais_model import PaisModel

class PaisService:
    def get_list(self):
        return PaisModel.query.all()

    def get_list_filter(self, filter_obj):
        return PaisModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PaisModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PaisModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PaisModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PaisModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()