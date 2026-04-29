from src import db
from sqlalchemy import text
from src.model.ponto_marcacao_model import PontoMarcacaoModel

class PontoMarcacaoService:
    def get_list(self):
        return PontoMarcacaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return PontoMarcacaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PontoMarcacaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PontoMarcacaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PontoMarcacaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PontoMarcacaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()