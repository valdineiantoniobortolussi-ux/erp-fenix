from src import db
from sqlalchemy import text
from src.model.estoque_cor_model import EstoqueCorModel

class EstoqueCorService:
    def get_list(self):
        return EstoqueCorModel.query.all()

    def get_list_filter(self, filter_obj):
        return EstoqueCorModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EstoqueCorModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EstoqueCorModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EstoqueCorModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EstoqueCorModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()