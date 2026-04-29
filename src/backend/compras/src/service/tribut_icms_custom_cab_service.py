from src import db
from sqlalchemy import text
from src.model.tribut_icms_custom_cab_model import TributIcmsCustomCabModel

class TributIcmsCustomCabService:
    def get_list(self):
        return TributIcmsCustomCabModel.query.all()

    def get_list_filter(self, filter_obj):
        return TributIcmsCustomCabModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return TributIcmsCustomCabModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = TributIcmsCustomCabModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = TributIcmsCustomCabModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = TributIcmsCustomCabModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()