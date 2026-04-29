from src import db
from sqlalchemy import text
from src.model.recado_remetente_model import RecadoRemetenteModel
from src.model.recado_destinatario_model import RecadoDestinatarioModel

class RecadoRemetenteService:
    def get_list(self):
        return RecadoRemetenteModel.query.all()

    def get_list_filter(self, filter_obj):
        return RecadoRemetenteModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return RecadoRemetenteModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = RecadoRemetenteModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = RecadoRemetenteModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = RecadoRemetenteModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # recadoDestinatarioModel
        children_data = data.get('recadoDestinatarioModelList', []) 
        for child_data in children_data:
            child = RecadoDestinatarioModel()
            child.mapping(child_data)
            parent.recado_destinatario_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # recadoDestinatarioModel
        for child in parent.recado_destinatario_model_list: 
            db.session.delete(child)

