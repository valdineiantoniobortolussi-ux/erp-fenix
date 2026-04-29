from src import db
from sqlalchemy import text
from src.model.produto_grupo_model import ProdutoGrupoModel

class ProdutoGrupoService:
    def get_list(self):
        return ProdutoGrupoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ProdutoGrupoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ProdutoGrupoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ProdutoGrupoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ProdutoGrupoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ProdutoGrupoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()