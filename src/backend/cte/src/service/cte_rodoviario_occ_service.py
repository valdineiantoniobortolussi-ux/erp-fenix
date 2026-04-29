from src import db
from sqlalchemy import text
from src.model.cte_rodoviario_occ_model import CteRodoviarioOccModel

class CteRodoviarioOccService:
    def get_list(self):
        return CteRodoviarioOccModel.query.all()

    def get_list_filter(self, filter_obj):
        return CteRodoviarioOccModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CteRodoviarioOccModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CteRodoviarioOccModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CteRodoviarioOccModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CteRodoviarioOccModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()