from src import db
from sqlalchemy import text
from src.model.esocial_tipo_afastamento_model import EsocialTipoAfastamentoModel

class EsocialTipoAfastamentoService:
    def get_list(self):
        return EsocialTipoAfastamentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return EsocialTipoAfastamentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EsocialTipoAfastamentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EsocialTipoAfastamentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EsocialTipoAfastamentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EsocialTipoAfastamentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()