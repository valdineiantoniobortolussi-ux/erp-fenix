from src import db
from sqlalchemy import text
from src.model.patrim_estado_conservacao_model import PatrimEstadoConservacaoModel

class PatrimEstadoConservacaoService:
    def get_list(self):
        return PatrimEstadoConservacaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return PatrimEstadoConservacaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PatrimEstadoConservacaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PatrimEstadoConservacaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PatrimEstadoConservacaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PatrimEstadoConservacaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()