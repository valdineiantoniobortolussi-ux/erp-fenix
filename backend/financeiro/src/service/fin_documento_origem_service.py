from src import db
from sqlalchemy import text
from src.model.fin_documento_origem_model import FinDocumentoOrigemModel

class FinDocumentoOrigemService:
    def get_list(self):
        return FinDocumentoOrigemModel.query.all()

    def get_list_filter(self, filter_obj):
        return FinDocumentoOrigemModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FinDocumentoOrigemModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FinDocumentoOrigemModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FinDocumentoOrigemModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FinDocumentoOrigemModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()