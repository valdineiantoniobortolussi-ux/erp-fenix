from src import db
from sqlalchemy import text
from src.model.contabil_lote_model import ContabilLoteModel

class ContabilLoteService:
    def get_list(self):
        return ContabilLoteModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilLoteModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilLoteModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilLoteModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilLoteModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilLoteModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()