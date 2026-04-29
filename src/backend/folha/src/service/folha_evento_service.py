from src import db
from sqlalchemy import text
from src.model.folha_evento_model import FolhaEventoModel

class FolhaEventoService:
    def get_list(self):
        return FolhaEventoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaEventoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaEventoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaEventoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaEventoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaEventoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()