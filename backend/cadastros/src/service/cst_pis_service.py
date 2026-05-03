from src import db
from sqlalchemy import text
from src.model.cst_pis_model import CstPisModel

class CstPisService:
    def get_list(self):
        return CstPisModel.query.all()

    def get_list_filter(self, filter_obj):
        return CstPisModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CstPisModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CstPisModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CstPisModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CstPisModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()