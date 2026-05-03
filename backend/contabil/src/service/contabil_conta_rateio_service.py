from src import db
from sqlalchemy import text
from src.model.contabil_conta_rateio_model import ContabilContaRateioModel

class ContabilContaRateioService:
    def get_list(self):
        return ContabilContaRateioModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilContaRateioModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilContaRateioModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilContaRateioModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilContaRateioModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilContaRateioModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()