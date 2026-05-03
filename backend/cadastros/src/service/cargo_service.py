from src import db
from sqlalchemy import text
from src.model.cargo_model import CargoModel

class CargoService:
    def get_list(self):
        return CargoModel.query.all()

    def get_list_filter(self, filter_obj):
        return CargoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CargoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CargoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CargoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CargoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()