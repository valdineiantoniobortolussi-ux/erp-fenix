from src import db
from sqlalchemy import text
from src.model.cte_rodoviario_pedagio_model import CteRodoviarioPedagioModel

class CteRodoviarioPedagioService:
    def get_list(self):
        return CteRodoviarioPedagioModel.query.all()

    def get_list_filter(self, filter_obj):
        return CteRodoviarioPedagioModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CteRodoviarioPedagioModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CteRodoviarioPedagioModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CteRodoviarioPedagioModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CteRodoviarioPedagioModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()