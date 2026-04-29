from src import db
from sqlalchemy import text
from src.model.os_status_model import OsStatusModel
from src.model.os_abertura_model import OsAberturaModel

class OsStatusService:
    def get_list(self):
        return OsStatusModel.query.all()

    def get_list_filter(self, filter_obj):
        return OsStatusModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return OsStatusModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = OsStatusModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = OsStatusModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = OsStatusModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # osAberturaModel
        children_data = data.get('osAberturaModelList', []) 
        for child_data in children_data:
            child = OsAberturaModel()
            child.mapping(child_data)
            parent.os_abertura_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # osAberturaModel
        for child in parent.os_abertura_model_list: 
            db.session.delete(child)

