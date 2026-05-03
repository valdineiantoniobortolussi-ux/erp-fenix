from src import db
from sqlalchemy import text
from src.model.ponto_parametro_model import PontoParametroModel

class PontoParametroService:
    def get_list(self):
        return PontoParametroModel.query.all()

    def get_list_filter(self, filter_obj):
        return PontoParametroModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PontoParametroModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PontoParametroModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PontoParametroModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PontoParametroModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()