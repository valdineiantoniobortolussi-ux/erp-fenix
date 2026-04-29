from src import db
from sqlalchemy import text
from src.model.fin_cheque_recebido_model import FinChequeRecebidoModel

class FinChequeRecebidoService:
    def get_list(self):
        return FinChequeRecebidoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FinChequeRecebidoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FinChequeRecebidoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FinChequeRecebidoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FinChequeRecebidoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FinChequeRecebidoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()