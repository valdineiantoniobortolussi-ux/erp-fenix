from src import db
from sqlalchemy import text
from src.model.frota_motorista_model import FrotaMotoristaModel

class FrotaMotoristaService:
    def get_list(self):
        return FrotaMotoristaModel.query.all()

    def get_list_filter(self, filter_obj):
        return FrotaMotoristaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FrotaMotoristaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FrotaMotoristaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FrotaMotoristaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FrotaMotoristaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()