from src import db
from sqlalchemy import text
from src.model.produto_model import ProdutoModel

class ProdutoService:
    def get_list(self):
        return ProdutoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ProdutoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ProdutoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ProdutoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ProdutoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ProdutoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()