from src import db
from sqlalchemy import text
from src.model.reuniao_sala_model import ReuniaoSalaModel

class ReuniaoSalaService:
    def get_list(self):
        return ReuniaoSalaModel.query.all()

    def get_list_filter(self, filter_obj):
        return ReuniaoSalaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ReuniaoSalaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ReuniaoSalaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ReuniaoSalaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ReuniaoSalaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()