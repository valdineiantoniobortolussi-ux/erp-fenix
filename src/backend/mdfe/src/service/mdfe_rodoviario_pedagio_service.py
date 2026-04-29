from src import db
from sqlalchemy import text
from src.model.mdfe_rodoviario_pedagio_model import MdfeRodoviarioPedagioModel

class MdfeRodoviarioPedagioService:
    def get_list(self):
        return MdfeRodoviarioPedagioModel.query.all()

    def get_list_filter(self, filter_obj):
        return MdfeRodoviarioPedagioModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return MdfeRodoviarioPedagioModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = MdfeRodoviarioPedagioModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = MdfeRodoviarioPedagioModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = MdfeRodoviarioPedagioModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()