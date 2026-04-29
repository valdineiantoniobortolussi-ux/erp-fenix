from src import db
from sqlalchemy import text
from src.model.folha_inss_model import FolhaInssModel
from src.model.folha_inss_retencao_model import FolhaInssRetencaoModel

class FolhaInssService:
    def get_list(self):
        return FolhaInssModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaInssModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaInssModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaInssModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaInssModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaInssModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # folhaInssRetencaoModel
        children_data = data.get('folhaInssRetencaoModelList', []) 
        for child_data in children_data:
            child = FolhaInssRetencaoModel()
            child.mapping(child_data)
            parent.folha_inss_retencao_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # folhaInssRetencaoModel
        for child in parent.folha_inss_retencao_model_list: 
            db.session.delete(child)

