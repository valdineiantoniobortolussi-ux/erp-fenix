from src import db
from sqlalchemy import text
from src.model.fiscal_nota_fiscal_saida_model import FiscalNotaFiscalSaidaModel

class FiscalNotaFiscalSaidaService:
    def get_list(self):
        return FiscalNotaFiscalSaidaModel.query.all()

    def get_list_filter(self, filter_obj):
        return FiscalNotaFiscalSaidaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FiscalNotaFiscalSaidaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FiscalNotaFiscalSaidaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FiscalNotaFiscalSaidaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FiscalNotaFiscalSaidaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()