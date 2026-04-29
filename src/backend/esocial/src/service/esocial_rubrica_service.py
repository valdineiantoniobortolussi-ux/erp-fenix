from src import db
from sqlalchemy import text
from src.model.esocial_rubrica_model import EsocialRubricaModel

class EsocialRubricaService:
    def get_list(self):
        return EsocialRubricaModel.query.all()

    def get_list_filter(self, filter_obj):
        return EsocialRubricaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EsocialRubricaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EsocialRubricaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EsocialRubricaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EsocialRubricaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()