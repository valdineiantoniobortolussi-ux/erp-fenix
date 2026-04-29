from src import db
from sqlalchemy import text
from src.model.patrim_tipo_aquisicao_bem_model import PatrimTipoAquisicaoBemModel

class PatrimTipoAquisicaoBemService:
    def get_list(self):
        return PatrimTipoAquisicaoBemModel.query.all()

    def get_list_filter(self, filter_obj):
        return PatrimTipoAquisicaoBemModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PatrimTipoAquisicaoBemModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PatrimTipoAquisicaoBemModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PatrimTipoAquisicaoBemModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PatrimTipoAquisicaoBemModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()