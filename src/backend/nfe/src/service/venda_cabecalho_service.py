from src import db
from sqlalchemy import text
from src.model.venda_cabecalho_model import VendaCabecalhoModel

class VendaCabecalhoService:
    def get_list(self):
        return VendaCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return VendaCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return VendaCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = VendaCabecalhoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = VendaCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = VendaCabecalhoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()