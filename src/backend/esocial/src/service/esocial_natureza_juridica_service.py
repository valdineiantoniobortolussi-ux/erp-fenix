from src import db
from sqlalchemy import text
from src.model.esocial_natureza_juridica_model import EsocialNaturezaJuridicaModel

class EsocialNaturezaJuridicaService:
    def get_list(self):
        return EsocialNaturezaJuridicaModel.query.all()

    def get_list_filter(self, filter_obj):
        return EsocialNaturezaJuridicaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EsocialNaturezaJuridicaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EsocialNaturezaJuridicaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EsocialNaturezaJuridicaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EsocialNaturezaJuridicaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()