from src import db
from sqlalchemy import text
from src.model.produto_marca_model import ProdutoMarcaModel

class ProdutoMarcaService:
    def get_list(self):
        return ProdutoMarcaModel.query.all()

    def get_list_filter(self, filter_obj):
        return ProdutoMarcaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ProdutoMarcaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ProdutoMarcaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ProdutoMarcaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ProdutoMarcaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()