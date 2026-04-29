from src import db
from sqlalchemy import text
from src.model.fiscal_municipal_regime_model import FiscalMunicipalRegimeModel

class FiscalMunicipalRegimeService:
    def get_list(self):
        return FiscalMunicipalRegimeModel.query.all()

    def get_list_filter(self, filter_obj):
        return FiscalMunicipalRegimeModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FiscalMunicipalRegimeModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FiscalMunicipalRegimeModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FiscalMunicipalRegimeModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FiscalMunicipalRegimeModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()