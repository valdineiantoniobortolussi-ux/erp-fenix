from src import db
from sqlalchemy import text
from src.model.gondola_caixa_model import GondolaCaixaModel
from src.model.gondola_armazenamento_model import GondolaArmazenamentoModel

class GondolaCaixaService:
    def get_list(self):
        return GondolaCaixaModel.query.all()

    def get_list_filter(self, filter_obj):
        return GondolaCaixaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return GondolaCaixaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = GondolaCaixaModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = GondolaCaixaModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = GondolaCaixaModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # gondolaArmazenamentoModel
        children_data = data.get('gondolaArmazenamentoModelList', []) 
        for child_data in children_data:
            child = GondolaArmazenamentoModel()
            child.mapping(child_data)
            parent.gondola_armazenamento_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # gondolaArmazenamentoModel
        for child in parent.gondola_armazenamento_model_list: 
            db.session.delete(child)

