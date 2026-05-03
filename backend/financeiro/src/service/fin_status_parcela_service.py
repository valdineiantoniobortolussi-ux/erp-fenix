from src import db
from sqlalchemy import text
from src.model.fin_status_parcela_model import FinStatusParcelaModel

class FinStatusParcelaService:
    def get_list(self):
        return FinStatusParcelaModel.query.all()

    def get_list_filter(self, filter_obj):
        return FinStatusParcelaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FinStatusParcelaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FinStatusParcelaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FinStatusParcelaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FinStatusParcelaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()