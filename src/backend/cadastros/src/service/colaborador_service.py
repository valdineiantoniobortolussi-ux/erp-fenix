from src import db
from sqlalchemy import text
from src.model.colaborador_model import ColaboradorModel
from src.model.vendedor_model import VendedorModel
from src.model.colaborador_relacionamento_model import ColaboradorRelacionamentoModel

class ColaboradorService:
    def get_list(self):
        return ColaboradorModel.query.all()

    def get_list_filter(self, filter_obj):
        return ColaboradorModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ColaboradorModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ColaboradorModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ColaboradorModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ColaboradorModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # vendedorModel
        child_data = data.get('vendedorModel') 
        if child_data:
            child = VendedorModel()
            child.mapping(child_data)
            parent.vendedor_model = child
            db.session.add(child)

        # colaboradorRelacionamentoModel
        children_data = data.get('colaboradorRelacionamentoModelList', []) 
        for child_data in children_data:
            child = ColaboradorRelacionamentoModel()
            child.mapping(child_data)
            parent.colaborador_relacionamento_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # vendedorModel
        if parent.vendedor_model: 
            db.session.delete(parent.vendedor_model)

        # colaboradorRelacionamentoModel
        for child in parent.colaborador_relacionamento_model_list: 
            db.session.delete(child)

