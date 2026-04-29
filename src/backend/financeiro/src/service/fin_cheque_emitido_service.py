from src import db
from sqlalchemy import text
from src.model.fin_cheque_emitido_model import FinChequeEmitidoModel

class FinChequeEmitidoService:
    def get_list(self):
        return FinChequeEmitidoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FinChequeEmitidoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FinChequeEmitidoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FinChequeEmitidoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FinChequeEmitidoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FinChequeEmitidoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()