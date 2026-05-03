from src import db
from sqlalchemy import text
from src.model.wms_rua_model import WmsRuaModel

class WmsRuaService:
    def get_list(self):
        return WmsRuaModel.query.all()

    def get_list_filter(self, filter_obj):
        return WmsRuaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return WmsRuaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = WmsRuaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = WmsRuaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = WmsRuaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()