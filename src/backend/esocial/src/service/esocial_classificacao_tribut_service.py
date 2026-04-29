from src import db
from sqlalchemy import text
from src.model.esocial_classificacao_tribut_model import EsocialClassificacaoTributModel

class EsocialClassificacaoTributService:
    def get_list(self):
        return EsocialClassificacaoTributModel.query.all()

    def get_list_filter(self, filter_obj):
        return EsocialClassificacaoTributModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EsocialClassificacaoTributModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EsocialClassificacaoTributModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EsocialClassificacaoTributModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EsocialClassificacaoTributModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()