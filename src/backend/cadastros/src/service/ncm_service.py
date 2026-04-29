from src import db
from sqlalchemy import text
from src.model.ncm_model import NcmModel

class NcmService:
    def get_list(self):
        return NcmModel.query.all()

    def get_list_filter(self, filter_obj):
        return NcmModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NcmModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NcmModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NcmModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NcmModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()