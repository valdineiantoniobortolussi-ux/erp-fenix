from src import db
from sqlalchemy import text
from src.model.folha_plano_saude_model import FolhaPlanoSaudeModel

class FolhaPlanoSaudeService:
    def get_list(self):
        return FolhaPlanoSaudeModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaPlanoSaudeModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaPlanoSaudeModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaPlanoSaudeModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaPlanoSaudeModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaPlanoSaudeModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()