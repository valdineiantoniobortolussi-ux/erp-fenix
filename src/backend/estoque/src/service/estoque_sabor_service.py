from src import db
from sqlalchemy import text
from src.model.estoque_sabor_model import EstoqueSaborModel

class EstoqueSaborService:
    def get_list(self):
        return EstoqueSaborModel.query.all()

    def get_list_filter(self, filter_obj):
        return EstoqueSaborModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EstoqueSaborModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EstoqueSaborModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EstoqueSaborModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EstoqueSaborModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()