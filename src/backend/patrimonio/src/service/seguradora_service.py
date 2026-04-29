from src import db
from sqlalchemy import text
from src.model.seguradora_model import SeguradoraModel

class SeguradoraService:
    def get_list(self):
        return SeguradoraModel.query.all()

    def get_list_filter(self, filter_obj):
        return SeguradoraModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return SeguradoraModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = SeguradoraModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = SeguradoraModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = SeguradoraModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()