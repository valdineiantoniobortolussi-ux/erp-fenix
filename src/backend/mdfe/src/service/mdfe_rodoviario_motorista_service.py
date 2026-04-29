from src import db
from sqlalchemy import text
from src.model.mdfe_rodoviario_motorista_model import MdfeRodoviarioMotoristaModel

class MdfeRodoviarioMotoristaService:
    def get_list(self):
        return MdfeRodoviarioMotoristaModel.query.all()

    def get_list_filter(self, filter_obj):
        return MdfeRodoviarioMotoristaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return MdfeRodoviarioMotoristaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = MdfeRodoviarioMotoristaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = MdfeRodoviarioMotoristaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = MdfeRodoviarioMotoristaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()