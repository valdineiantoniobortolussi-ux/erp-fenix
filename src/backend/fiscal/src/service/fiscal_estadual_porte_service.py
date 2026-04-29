from src import db
from sqlalchemy import text
from src.model.fiscal_estadual_porte_model import FiscalEstadualPorteModel

class FiscalEstadualPorteService:
    def get_list(self):
        return FiscalEstadualPorteModel.query.all()

    def get_list_filter(self, filter_obj):
        return FiscalEstadualPorteModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FiscalEstadualPorteModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FiscalEstadualPorteModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FiscalEstadualPorteModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FiscalEstadualPorteModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()