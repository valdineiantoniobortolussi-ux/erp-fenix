from src import db
from sqlalchemy import text
from src.model.sped_contabil_model import SpedContabilModel

class SpedContabilService:
    def get_list(self):
        return SpedContabilModel.query.all()

    def get_list_filter(self, filter_obj):
        return SpedContabilModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return SpedContabilModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = SpedContabilModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = SpedContabilModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = SpedContabilModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()