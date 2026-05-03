from src import db
from sqlalchemy import text
from src.model.cst_icms_model import CstIcmsModel

class CstIcmsService:
    def get_list(self):
        return CstIcmsModel.query.all()

    def get_list_filter(self, filter_obj):
        return CstIcmsModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CstIcmsModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CstIcmsModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CstIcmsModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CstIcmsModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()