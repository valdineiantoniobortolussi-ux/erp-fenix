from src import db
from sqlalchemy import text
from src.model.contabil_indice_model import ContabilIndiceModel
from src.model.contabil_indice_valor_model import ContabilIndiceValorModel

class ContabilIndiceService:
    def get_list(self):
        return ContabilIndiceModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilIndiceModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilIndiceModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilIndiceModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilIndiceModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilIndiceModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # contabilIndiceValorModel
        children_data = data.get('contabilIndiceValorModelList', []) 
        for child_data in children_data:
            child = ContabilIndiceValorModel()
            child.mapping(child_data)
            parent.contabil_indice_valor_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # contabilIndiceValorModel
        for child in parent.contabil_indice_valor_model_list: 
            db.session.delete(child)

