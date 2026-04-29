from src import db
from sqlalchemy import text
from src.model.folha_vale_transporte_model import FolhaValeTransporteModel

class FolhaValeTransporteService:
    def get_list(self):
        return FolhaValeTransporteModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaValeTransporteModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaValeTransporteModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaValeTransporteModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaValeTransporteModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaValeTransporteModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()