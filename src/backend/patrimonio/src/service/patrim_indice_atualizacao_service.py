from src import db
from sqlalchemy import text
from src.model.patrim_indice_atualizacao_model import PatrimIndiceAtualizacaoModel

class PatrimIndiceAtualizacaoService:
    def get_list(self):
        return PatrimIndiceAtualizacaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return PatrimIndiceAtualizacaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PatrimIndiceAtualizacaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PatrimIndiceAtualizacaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PatrimIndiceAtualizacaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PatrimIndiceAtualizacaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()