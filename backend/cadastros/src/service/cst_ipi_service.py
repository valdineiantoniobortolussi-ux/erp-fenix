from src import db
from sqlalchemy import text
from src.model.cst_ipi_model import CstIpiModel

class CstIpiService:
    def get_list(self):
        return CstIpiModel.query.all()

    def get_list_filter(self, filter_obj):
        return CstIpiModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CstIpiModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CstIpiModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CstIpiModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CstIpiModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()