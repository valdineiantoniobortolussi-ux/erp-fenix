from src import db
from sqlalchemy import text
from src.model.os_status_model import OsStatusModel

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
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = OsStatusModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = OsStatusModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()