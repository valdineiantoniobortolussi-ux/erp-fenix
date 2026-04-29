from src import db
from sqlalchemy import text
from src.model.comissao_objetivo_model import ComissaoObjetivoModel

class ComissaoObjetivoService:
    def get_list(self):
        return ComissaoObjetivoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ComissaoObjetivoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ComissaoObjetivoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ComissaoObjetivoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ComissaoObjetivoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ComissaoObjetivoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()