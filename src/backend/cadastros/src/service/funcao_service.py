from src import db
from sqlalchemy import text
from src.model.funcao_model import FuncaoModel
from src.model.papel_funcao_model import PapelFuncaoModel

class FuncaoService:
    def get_list(self):
        return FuncaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FuncaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FuncaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FuncaoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FuncaoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FuncaoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # papelFuncaoModel
        children_data = data.get('papelFuncaoModelList', []) 
        for child_data in children_data:
            child = PapelFuncaoModel()
            child.mapping(child_data)
            parent.papel_funcao_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # papelFuncaoModel
        for child in parent.papel_funcao_model_list: 
            db.session.delete(child)

