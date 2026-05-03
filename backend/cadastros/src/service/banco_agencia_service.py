from src import db
from sqlalchemy import text
from src.model.banco_agencia_model import BancoAgenciaModel

class BancoAgenciaService:
    def get_list(self):
        return BancoAgenciaModel.query.all()

    def get_list_filter(self, filter_obj):
        return BancoAgenciaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return BancoAgenciaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = BancoAgenciaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = BancoAgenciaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = BancoAgenciaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()