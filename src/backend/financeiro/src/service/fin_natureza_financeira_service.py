from src import db
from sqlalchemy import text
from src.model.fin_natureza_financeira_model import FinNaturezaFinanceiraModel

class FinNaturezaFinanceiraService:
    def get_list(self):
        return FinNaturezaFinanceiraModel.query.all()

    def get_list_filter(self, filter_obj):
        return FinNaturezaFinanceiraModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FinNaturezaFinanceiraModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FinNaturezaFinanceiraModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FinNaturezaFinanceiraModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FinNaturezaFinanceiraModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()