from src import db
from sqlalchemy import text
from src.model.wms_estante_model import WmsEstanteModel

class WmsEstanteService:
    def get_list(self):
        return WmsEstanteModel.query.all()

    def get_list_filter(self, filter_obj):
        return WmsEstanteModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return WmsEstanteModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = WmsEstanteModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = WmsEstanteModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = WmsEstanteModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()