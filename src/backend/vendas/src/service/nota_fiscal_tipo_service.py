from src import db
from sqlalchemy import text
from src.model.nota_fiscal_tipo_model import NotaFiscalTipoModel

class NotaFiscalTipoService:
    def get_list(self):
        return NotaFiscalTipoModel.query.all()

    def get_list_filter(self, filter_obj):
        return NotaFiscalTipoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NotaFiscalTipoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NotaFiscalTipoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NotaFiscalTipoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NotaFiscalTipoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()