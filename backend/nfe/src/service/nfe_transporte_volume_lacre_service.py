from src import db
from sqlalchemy import text
from src.model.nfe_transporte_volume_lacre_model import NfeTransporteVolumeLacreModel

class NfeTransporteVolumeLacreService:
    def get_list(self):
        return NfeTransporteVolumeLacreModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeTransporteVolumeLacreModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeTransporteVolumeLacreModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeTransporteVolumeLacreModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeTransporteVolumeLacreModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeTransporteVolumeLacreModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()