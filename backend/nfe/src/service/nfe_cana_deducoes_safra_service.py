from src import db
from sqlalchemy import text
from src.model.nfe_cana_deducoes_safra_model import NfeCanaDeducoesSafraModel

class NfeCanaDeducoesSafraService:
    def get_list(self):
        return NfeCanaDeducoesSafraModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeCanaDeducoesSafraModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeCanaDeducoesSafraModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeCanaDeducoesSafraModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeCanaDeducoesSafraModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeCanaDeducoesSafraModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()