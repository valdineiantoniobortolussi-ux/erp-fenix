from src import db
from sqlalchemy import text
from src.model.papel_model import PapelModel
from src.model.papel_funcao_model import PapelFuncaoModel
from src.model.usuario_model import UsuarioModel

class PapelService:
    def get_list(self):
        return PapelModel.query.all()

    def get_list_filter(self, filter_obj):
        return PapelModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PapelModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PapelModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PapelModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PapelModel.query.get_or_404(id)
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

        # usuarioModel
        children_data = data.get('usuarioModelList', []) 
        for child_data in children_data:
            child = UsuarioModel()
            child.mapping(child_data)
            parent.usuario_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # papelFuncaoModel
        for child in parent.papel_funcao_model_list: 
            db.session.delete(child)

        # usuarioModel
        for child in parent.usuario_model_list: 
            db.session.delete(child)

