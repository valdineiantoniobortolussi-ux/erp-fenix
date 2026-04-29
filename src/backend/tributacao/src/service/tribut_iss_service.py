from src import db
from sqlalchemy import text
from src.model.tribut_iss_model import TributIssModel

class TributIssService:
    def get_list(self):
        return TributIssModel.query.all()

    def get_list_filter(self, filter_obj):
        return TributIssModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return TributIssModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = TributIssModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = TributIssModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = TributIssModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()