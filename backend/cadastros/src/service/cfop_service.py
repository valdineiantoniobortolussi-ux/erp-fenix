from src import db
from sqlalchemy import text
from src.model.cfop_model import CfopModel

class CfopService:
    def get_list(self):
        return CfopModel.query.all()

    def get_list_filter(self, filter_obj):
        return CfopModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CfopModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CfopModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CfopModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CfopModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()