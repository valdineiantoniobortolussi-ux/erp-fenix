from src import db
from sqlalchemy import text
from src.model.cte_inf_nf_transporte_lacre_model import CteInfNfTransporteLacreModel

class CteInfNfTransporteLacreService:
    def get_list(self):
        return CteInfNfTransporteLacreModel.query.all()

    def get_list_filter(self, filter_obj):
        return CteInfNfTransporteLacreModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CteInfNfTransporteLacreModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CteInfNfTransporteLacreModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CteInfNfTransporteLacreModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CteInfNfTransporteLacreModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()