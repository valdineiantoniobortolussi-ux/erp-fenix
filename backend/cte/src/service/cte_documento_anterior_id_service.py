from src import db
from sqlalchemy import text
from src.model.cte_documento_anterior_id_model import CteDocumentoAnteriorIdModel

class CteDocumentoAnteriorIdService:
    def get_list(self):
        return CteDocumentoAnteriorIdModel.query.all()

    def get_list_filter(self, filter_obj):
        return CteDocumentoAnteriorIdModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CteDocumentoAnteriorIdModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CteDocumentoAnteriorIdModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CteDocumentoAnteriorIdModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CteDocumentoAnteriorIdModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()