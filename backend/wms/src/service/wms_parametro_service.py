from src import db
from sqlalchemy import text
from src.model.wms_parametro_model import WmsParametroModel

class WmsParametroService:
    def get_list(self):
        return WmsParametroModel.query.all()

    def get_list_filter(self, filter_obj):
        return WmsParametroModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return WmsParametroModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = WmsParametroModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = WmsParametroModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = WmsParametroModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()