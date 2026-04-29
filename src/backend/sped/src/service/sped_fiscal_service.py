from src import db
from sqlalchemy import text
from src.model.sped_fiscal_model import SpedFiscalModel

class SpedFiscalService:
    def get_list(self):
        return SpedFiscalModel.query.all()

    def get_list_filter(self, filter_obj):
        return SpedFiscalModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return SpedFiscalModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = SpedFiscalModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = SpedFiscalModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = SpedFiscalModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()