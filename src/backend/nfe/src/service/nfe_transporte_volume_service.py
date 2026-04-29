from src import db
from sqlalchemy import text
from src.model.nfe_transporte_volume_model import NfeTransporteVolumeModel

class NfeTransporteVolumeService:
    def get_list(self):
        return NfeTransporteVolumeModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeTransporteVolumeModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeTransporteVolumeModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeTransporteVolumeModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeTransporteVolumeModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeTransporteVolumeModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()