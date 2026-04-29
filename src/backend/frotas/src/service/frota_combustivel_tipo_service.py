from src import db
from sqlalchemy import text
from src.model.frota_combustivel_tipo_model import FrotaCombustivelTipoModel

class FrotaCombustivelTipoService:
    def get_list(self):
        return FrotaCombustivelTipoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FrotaCombustivelTipoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FrotaCombustivelTipoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FrotaCombustivelTipoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FrotaCombustivelTipoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FrotaCombustivelTipoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()