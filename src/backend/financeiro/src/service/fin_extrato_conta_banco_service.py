from src import db
from sqlalchemy import text
from src.model.fin_extrato_conta_banco_model import FinExtratoContaBancoModel

class FinExtratoContaBancoService:
    def get_list(self):
        return FinExtratoContaBancoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FinExtratoContaBancoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FinExtratoContaBancoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FinExtratoContaBancoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FinExtratoContaBancoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FinExtratoContaBancoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()