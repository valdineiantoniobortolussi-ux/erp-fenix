from src import db
from sqlalchemy import text
from src.model.fiscal_nota_fiscal_entrada_model import FiscalNotaFiscalEntradaModel

class FiscalNotaFiscalEntradaService:
    def get_list(self):
        return FiscalNotaFiscalEntradaModel.query.all()

    def get_list_filter(self, filter_obj):
        return FiscalNotaFiscalEntradaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FiscalNotaFiscalEntradaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FiscalNotaFiscalEntradaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FiscalNotaFiscalEntradaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FiscalNotaFiscalEntradaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()