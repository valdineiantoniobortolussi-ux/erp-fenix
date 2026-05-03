from src import db
from sqlalchemy import text
from src.model.ged_tipo_documento_model import GedTipoDocumentoModel

class GedTipoDocumentoService:
    def get_list(self):
        return GedTipoDocumentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return GedTipoDocumentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return GedTipoDocumentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = GedTipoDocumentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = GedTipoDocumentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = GedTipoDocumentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()