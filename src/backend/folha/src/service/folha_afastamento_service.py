from src import db
from sqlalchemy import text
from src.model.folha_afastamento_model import FolhaAfastamentoModel

class FolhaAfastamentoService:
    def get_list(self):
        return FolhaAfastamentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaAfastamentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaAfastamentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaAfastamentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaAfastamentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaAfastamentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()