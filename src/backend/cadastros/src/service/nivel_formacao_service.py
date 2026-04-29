from src import db
from sqlalchemy import text
from src.model.nivel_formacao_model import NivelFormacaoModel

class NivelFormacaoService:
    def get_list(self):
        return NivelFormacaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return NivelFormacaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NivelFormacaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NivelFormacaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NivelFormacaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NivelFormacaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()