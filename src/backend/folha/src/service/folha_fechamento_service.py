from src import db
from sqlalchemy import text
from src.model.folha_fechamento_model import FolhaFechamentoModel

class FolhaFechamentoService:
    def get_list(self):
        return FolhaFechamentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaFechamentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaFechamentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaFechamentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaFechamentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaFechamentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()