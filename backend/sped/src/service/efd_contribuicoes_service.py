from src import db
from sqlalchemy import text
from src.model.efd_contribuicoes_model import EfdContribuicoesModel

class EfdContribuicoesService:
    def get_list(self):
        return EfdContribuicoesModel.query.all()

    def get_list_filter(self, filter_obj):
        return EfdContribuicoesModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EfdContribuicoesModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EfdContribuicoesModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EfdContribuicoesModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EfdContribuicoesModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()