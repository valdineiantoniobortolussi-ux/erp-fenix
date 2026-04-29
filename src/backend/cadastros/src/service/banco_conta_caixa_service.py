from src import db
from sqlalchemy import text
from src.model.banco_conta_caixa_model import BancoContaCaixaModel

class BancoContaCaixaService:
    def get_list(self):
        return BancoContaCaixaModel.query.all()

    def get_list_filter(self, filter_obj):
        return BancoContaCaixaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return BancoContaCaixaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = BancoContaCaixaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = BancoContaCaixaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = BancoContaCaixaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()