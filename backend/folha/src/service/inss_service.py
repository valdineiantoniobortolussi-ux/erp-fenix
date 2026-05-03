from src import db
from sqlalchemy import text
from src.model.inss_model import InssModel
from src.model.salario_familia_model import SalarioFamiliaModel
from src.model.inss_detalhe_model import InssDetalheModel

class InssService:
    def get_list(self):
        return InssModel.query.all()

    def get_list_filter(self, filter_obj):
        return InssModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return InssModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = InssModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = InssModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = InssModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # salarioFamiliaModel
        children_data = data.get('salarioFamiliaModelList', []) 
        for child_data in children_data:
            child = SalarioFamiliaModel()
            child.mapping(child_data)
            parent.salario_familia_model_list.append(child)
            db.session.add(child)

        # inssDetalheModel
        children_data = data.get('inssDetalheModelList', []) 
        for child_data in children_data:
            child = InssDetalheModel()
            child.mapping(child_data)
            parent.inss_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # salarioFamiliaModel
        for child in parent.salario_familia_model_list: 
            db.session.delete(child)

        # inssDetalheModel
        for child in parent.inss_detalhe_model_list: 
            db.session.delete(child)

