from src import db
from sqlalchemy import text
from src.model.estoque_marca_model import EstoqueMarcaModel

class EstoqueMarcaService:
    def get_list(self):
        return EstoqueMarcaModel.query.all()

    def get_list_filter(self, filter_obj):
        return EstoqueMarcaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EstoqueMarcaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EstoqueMarcaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EstoqueMarcaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EstoqueMarcaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()