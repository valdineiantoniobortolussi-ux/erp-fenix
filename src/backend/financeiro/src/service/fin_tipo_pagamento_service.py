from src import db
from sqlalchemy import text
from src.model.fin_tipo_pagamento_model import FinTipoPagamentoModel

class FinTipoPagamentoService:
    def get_list(self):
        return FinTipoPagamentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FinTipoPagamentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FinTipoPagamentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FinTipoPagamentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FinTipoPagamentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FinTipoPagamentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()