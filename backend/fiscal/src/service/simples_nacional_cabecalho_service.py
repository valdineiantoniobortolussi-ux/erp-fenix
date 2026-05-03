from src import db
from sqlalchemy import text
from src.model.simples_nacional_cabecalho_model import SimplesNacionalCabecalhoModel
from src.model.simples_nacional_detalhe_model import SimplesNacionalDetalheModel

class SimplesNacionalCabecalhoService:
    def get_list(self):
        return SimplesNacionalCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return SimplesNacionalCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return SimplesNacionalCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = SimplesNacionalCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = SimplesNacionalCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = SimplesNacionalCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # simplesNacionalDetalheModel
        children_data = data.get('simplesNacionalDetalheModelList', []) 
        for child_data in children_data:
            child = SimplesNacionalDetalheModel()
            child.mapping(child_data)
            parent.simples_nacional_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # simplesNacionalDetalheModel
        for child in parent.simples_nacional_detalhe_model_list: 
            db.session.delete(child)

