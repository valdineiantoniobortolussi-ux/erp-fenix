from src import db
from sqlalchemy import text
from src.model.tipo_contrato_model import TipoContratoModel

class TipoContratoService:
    def get_list(self):
        return TipoContratoModel.query.all()

    def get_list_filter(self, filter_obj):
        return TipoContratoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return TipoContratoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = TipoContratoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = TipoContratoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = TipoContratoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()