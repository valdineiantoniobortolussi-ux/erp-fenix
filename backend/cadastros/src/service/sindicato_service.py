from src import db
from sqlalchemy import text
from src.model.sindicato_model import SindicatoModel

class SindicatoService:
    def get_list(self):
        return SindicatoModel.query.all()

    def get_list_filter(self, filter_obj):
        return SindicatoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return SindicatoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = SindicatoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = SindicatoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = SindicatoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()