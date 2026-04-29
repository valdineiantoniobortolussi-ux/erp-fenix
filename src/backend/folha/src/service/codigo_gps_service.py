from src import db
from sqlalchemy import text
from src.model.codigo_gps_model import CodigoGpsModel

class CodigoGpsService:
    def get_list(self):
        return CodigoGpsModel.query.all()

    def get_list_filter(self, filter_obj):
        return CodigoGpsModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CodigoGpsModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CodigoGpsModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CodigoGpsModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CodigoGpsModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()