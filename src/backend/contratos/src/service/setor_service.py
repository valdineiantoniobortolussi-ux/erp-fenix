from src import db
from sqlalchemy import text
from src.model.setor_model import SetorModel

class SetorService:
    def get_list(self):
        return SetorModel.query.all()

    def get_list_filter(self, filter_obj):
        return SetorModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return SetorModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = SetorModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = SetorModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = SetorModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()