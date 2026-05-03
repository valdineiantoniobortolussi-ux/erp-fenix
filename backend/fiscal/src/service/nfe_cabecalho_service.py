from src import db
from sqlalchemy import text
from src.model.nfe_cabecalho_model import NfeCabecalhoModel

class NfeCabecalhoService:
    def get_list(self):
        return NfeCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeCabecalhoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeCabecalhoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()