from src import db
from sqlalchemy import text
from src.model.contabil_livro_model import ContabilLivroModel
from src.model.contabil_termo_model import ContabilTermoModel

class ContabilLivroService:
    def get_list(self):
        return ContabilLivroModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilLivroModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilLivroModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilLivroModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilLivroModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilLivroModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # contabilTermoModel
        children_data = data.get('contabilTermoModelList', []) 
        for child_data in children_data:
            child = ContabilTermoModel()
            child.mapping(child_data)
            parent.contabil_termo_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # contabilTermoModel
        for child in parent.contabil_termo_model_list: 
            db.session.delete(child)

