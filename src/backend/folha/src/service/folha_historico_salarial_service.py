from src import db
from sqlalchemy import text
from src.model.folha_historico_salarial_model import FolhaHistoricoSalarialModel

class FolhaHistoricoSalarialService:
    def get_list(self):
        return FolhaHistoricoSalarialModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaHistoricoSalarialModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaHistoricoSalarialModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaHistoricoSalarialModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaHistoricoSalarialModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaHistoricoSalarialModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()