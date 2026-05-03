from src import db
from sqlalchemy import text
from src.model.irrf_model import IrrfModel
from src.model.irrf_detalhe_model import IrrfDetalheModel

class IrrfService:
    def get_list(self):
        return IrrfModel.query.all()

    def get_list_filter(self, filter_obj):
        return IrrfModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return IrrfModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = IrrfModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = IrrfModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = IrrfModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # irrfDetalheModel
        children_data = data.get('irrfDetalheModelList', []) 
        for child_data in children_data:
            child = IrrfDetalheModel()
            child.mapping(child_data)
            parent.irrf_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # irrfDetalheModel
        for child in parent.irrf_detalhe_model_list: 
            db.session.delete(child)

