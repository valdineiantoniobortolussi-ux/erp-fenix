from src import db
from sqlalchemy import text
from src.model.produto_unidade_model import ProdutoUnidadeModel

class ProdutoUnidadeService:
    def get_list(self):
        return ProdutoUnidadeModel.query.all()

    def get_list_filter(self, filter_obj):
        return ProdutoUnidadeModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ProdutoUnidadeModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ProdutoUnidadeModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ProdutoUnidadeModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ProdutoUnidadeModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()