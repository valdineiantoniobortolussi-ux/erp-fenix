from src import db
from sqlalchemy import text
from src.model.ged_versao_documento_model import GedVersaoDocumentoModel

class GedVersaoDocumentoService:
    def get_list(self):
        return GedVersaoDocumentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return GedVersaoDocumentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return GedVersaoDocumentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = GedVersaoDocumentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = GedVersaoDocumentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = GedVersaoDocumentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()