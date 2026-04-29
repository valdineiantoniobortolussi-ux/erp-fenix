from src import db
from sqlalchemy import text
from src.model.nfe_importacao_detalhe_model import NfeImportacaoDetalheModel

class NfeImportacaoDetalheService:
    def get_list(self):
        return NfeImportacaoDetalheModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeImportacaoDetalheModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeImportacaoDetalheModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeImportacaoDetalheModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeImportacaoDetalheModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeImportacaoDetalheModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()