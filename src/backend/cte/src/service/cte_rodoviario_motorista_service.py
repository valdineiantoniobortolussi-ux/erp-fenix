from src import db
from sqlalchemy import text
from src.model.cte_rodoviario_motorista_model import CteRodoviarioMotoristaModel

class CteRodoviarioMotoristaService:
    def get_list(self):
        return CteRodoviarioMotoristaModel.query.all()

    def get_list_filter(self, filter_obj):
        return CteRodoviarioMotoristaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CteRodoviarioMotoristaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CteRodoviarioMotoristaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CteRodoviarioMotoristaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CteRodoviarioMotoristaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()