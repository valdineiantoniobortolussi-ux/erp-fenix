from src import db
from sqlalchemy import text
from src.model.etiqueta_layout_model import EtiquetaLayoutModel
from src.model.etiqueta_template_model import EtiquetaTemplateModel

class EtiquetaLayoutService:
    def get_list(self):
        return EtiquetaLayoutModel.query.all()

    def get_list_filter(self, filter_obj):
        return EtiquetaLayoutModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EtiquetaLayoutModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EtiquetaLayoutModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EtiquetaLayoutModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EtiquetaLayoutModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # etiquetaTemplateModel
        children_data = data.get('etiquetaTemplateModelList', []) 
        for child_data in children_data:
            child = EtiquetaTemplateModel()
            child.mapping(child_data)
            parent.etiqueta_template_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # etiquetaTemplateModel
        for child in parent.etiqueta_template_model_list: 
            db.session.delete(child)

