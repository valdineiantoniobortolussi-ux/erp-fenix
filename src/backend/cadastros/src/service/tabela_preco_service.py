from src import db
from sqlalchemy import text
from src.model.tabela_preco_model import TabelaPrecoModel

class TabelaPrecoService:
    def get_list(self):
        return TabelaPrecoModel.query.all()

    def get_list_filter(self, filter_obj):
        return TabelaPrecoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return TabelaPrecoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = TabelaPrecoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = TabelaPrecoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = TabelaPrecoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()