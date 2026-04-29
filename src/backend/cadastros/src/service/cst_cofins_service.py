from src import db
from sqlalchemy import text
from src.model.cst_cofins_model import CstCofinsModel

class CstCofinsService:
    def get_list(self):
        return CstCofinsModel.query.all()

    def get_list_filter(self, filter_obj):
        return CstCofinsModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CstCofinsModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CstCofinsModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CstCofinsModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CstCofinsModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()