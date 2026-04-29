from src import db
from sqlalchemy import text
from src.model.municipio_model import MunicipioModel

class MunicipioService:
    def get_list(self):
        return MunicipioModel.query.all()

    def get_list_filter(self, filter_obj):
        return MunicipioModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return MunicipioModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = MunicipioModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = MunicipioModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = MunicipioModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()