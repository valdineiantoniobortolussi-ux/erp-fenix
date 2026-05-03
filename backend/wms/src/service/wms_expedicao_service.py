from src import db
from sqlalchemy import text
from src.model.wms_expedicao_model import WmsExpedicaoModel

class WmsExpedicaoService:
    def get_list(self):
        return WmsExpedicaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return WmsExpedicaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return WmsExpedicaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = WmsExpedicaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = WmsExpedicaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = WmsExpedicaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()