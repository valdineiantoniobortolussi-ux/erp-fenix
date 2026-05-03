from src import db
from sqlalchemy import text
from src.model.registro_cartorio_model import RegistroCartorioModel

class RegistroCartorioService:
    def get_list(self):
        return RegistroCartorioModel.query.all()

    def get_list_filter(self, filter_obj):
        return RegistroCartorioModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return RegistroCartorioModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = RegistroCartorioModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = RegistroCartorioModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = RegistroCartorioModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()