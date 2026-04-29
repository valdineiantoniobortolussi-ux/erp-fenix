from src import db
from sqlalchemy import text
from src.model.fiscal_apuracao_icms_model import FiscalApuracaoIcmsModel

class FiscalApuracaoIcmsService:
    def get_list(self):
        return FiscalApuracaoIcmsModel.query.all()

    def get_list_filter(self, filter_obj):
        return FiscalApuracaoIcmsModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FiscalApuracaoIcmsModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FiscalApuracaoIcmsModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FiscalApuracaoIcmsModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FiscalApuracaoIcmsModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()