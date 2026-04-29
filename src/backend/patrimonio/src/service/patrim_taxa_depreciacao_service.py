from src import db
from sqlalchemy import text
from src.model.patrim_taxa_depreciacao_model import PatrimTaxaDepreciacaoModel

class PatrimTaxaDepreciacaoService:
    def get_list(self):
        return PatrimTaxaDepreciacaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return PatrimTaxaDepreciacaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PatrimTaxaDepreciacaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PatrimTaxaDepreciacaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PatrimTaxaDepreciacaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PatrimTaxaDepreciacaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()