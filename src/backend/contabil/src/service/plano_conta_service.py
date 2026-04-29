from src import db
from sqlalchemy import text
from src.model.plano_conta_model import PlanoContaModel

class PlanoContaService:
    def get_list(self):
        return PlanoContaModel.query.all()

    def get_list_filter(self, filter_obj):
        return PlanoContaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PlanoContaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PlanoContaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PlanoContaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PlanoContaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()