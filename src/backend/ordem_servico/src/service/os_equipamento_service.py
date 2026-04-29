from src import db
from sqlalchemy import text
from src.model.os_equipamento_model import OsEquipamentoModel

class OsEquipamentoService:
    def get_list(self):
        return OsEquipamentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return OsEquipamentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return OsEquipamentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = OsEquipamentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = OsEquipamentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = OsEquipamentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()