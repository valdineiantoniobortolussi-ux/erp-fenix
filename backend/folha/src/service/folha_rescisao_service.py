from src import db
from sqlalchemy import text
from src.model.folha_rescisao_model import FolhaRescisaoModel

class FolhaRescisaoService:
    def get_list(self):
        return FolhaRescisaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaRescisaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaRescisaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaRescisaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaRescisaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaRescisaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()