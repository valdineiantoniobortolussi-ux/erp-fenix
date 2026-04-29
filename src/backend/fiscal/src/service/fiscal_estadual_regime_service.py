from src import db
from sqlalchemy import text
from src.model.fiscal_estadual_regime_model import FiscalEstadualRegimeModel

class FiscalEstadualRegimeService:
    def get_list(self):
        return FiscalEstadualRegimeModel.query.all()

    def get_list_filter(self, filter_obj):
        return FiscalEstadualRegimeModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FiscalEstadualRegimeModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FiscalEstadualRegimeModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FiscalEstadualRegimeModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FiscalEstadualRegimeModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()