from src import db
from sqlalchemy import text
from src.model.nfe_numero_inutilizado_model import NfeNumeroInutilizadoModel

class NfeNumeroInutilizadoService:
    def get_list(self):
        return NfeNumeroInutilizadoModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeNumeroInutilizadoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeNumeroInutilizadoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeNumeroInutilizadoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeNumeroInutilizadoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeNumeroInutilizadoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()