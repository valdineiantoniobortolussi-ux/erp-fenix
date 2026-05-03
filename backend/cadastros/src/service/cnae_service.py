from src import db
from sqlalchemy import text
from src.model.cnae_model import CnaeModel

class CnaeService:
    def get_list(self):
        return CnaeModel.query.all()

    def get_list_filter(self, filter_obj):
        return CnaeModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CnaeModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CnaeModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CnaeModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CnaeModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()