from src import db
from sqlalchemy import text
from src.model.nfe_duplicata_model import NfeDuplicataModel

class NfeDuplicataService:
    def get_list(self):
        return NfeDuplicataModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeDuplicataModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeDuplicataModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeDuplicataModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeDuplicataModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeDuplicataModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()