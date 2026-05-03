from src import db
from sqlalchemy import text
from src.model.produto_subgrupo_model import ProdutoSubgrupoModel

class ProdutoSubgrupoService:
    def get_list(self):
        return ProdutoSubgrupoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ProdutoSubgrupoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ProdutoSubgrupoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ProdutoSubgrupoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ProdutoSubgrupoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ProdutoSubgrupoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()