from src import db
from sqlalchemy import text
from src.model.fiscal_livro_model import FiscalLivroModel
from src.model.fiscal_termo_model import FiscalTermoModel

class FiscalLivroService:
    def get_list(self):
        return FiscalLivroModel.query.all()

    def get_list_filter(self, filter_obj):
        return FiscalLivroModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FiscalLivroModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FiscalLivroModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FiscalLivroModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FiscalLivroModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # fiscalTermoModel
        children_data = data.get('fiscalTermoModelList', []) 
        for child_data in children_data:
            child = FiscalTermoModel()
            child.mapping(child_data)
            parent.fiscal_termo_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # fiscalTermoModel
        for child in parent.fiscal_termo_model_list: 
            db.session.delete(child)

