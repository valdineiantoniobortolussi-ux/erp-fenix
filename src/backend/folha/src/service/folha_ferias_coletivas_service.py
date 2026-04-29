from src import db
from sqlalchemy import text
from src.model.folha_ferias_coletivas_model import FolhaFeriasColetivasModel

class FolhaFeriasColetivasService:
    def get_list(self):
        return FolhaFeriasColetivasModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaFeriasColetivasModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaFeriasColetivasModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaFeriasColetivasModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaFeriasColetivasModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaFeriasColetivasModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()