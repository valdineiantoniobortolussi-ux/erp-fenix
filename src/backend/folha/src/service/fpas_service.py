from src import db
from sqlalchemy import text
from src.model.fpas_model import FpasModel

class FpasService:
    def get_list(self):
        return FpasModel.query.all()

    def get_list_filter(self, filter_obj):
        return FpasModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FpasModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FpasModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FpasModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FpasModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()