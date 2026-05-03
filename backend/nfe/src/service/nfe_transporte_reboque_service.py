from src import db
from sqlalchemy import text
from src.model.nfe_transporte_reboque_model import NfeTransporteReboqueModel

class NfeTransporteReboqueService:
    def get_list(self):
        return NfeTransporteReboqueModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeTransporteReboqueModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeTransporteReboqueModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeTransporteReboqueModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeTransporteReboqueModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeTransporteReboqueModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()