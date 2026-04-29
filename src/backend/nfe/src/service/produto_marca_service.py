from src import db
from sqlalchemy import text
from src.model.produto_marca_model import ProdutoMarcaModel
from src.model.produto_model import ProdutoModel

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
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ProdutoMarcaModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ProdutoMarcaModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # produtoModel
        children_data = data.get('produtoModelList', []) 
        for child_data in children_data:
            child = ProdutoModel()
            child.mapping(child_data)
            parent.produto_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # produtoModel
        for child in parent.produto_model_list: 
            db.session.delete(child)

