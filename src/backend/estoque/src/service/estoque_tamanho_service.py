from src import db
from sqlalchemy import text
from src.model.estoque_tamanho_model import EstoqueTamanhoModel

class EstoqueTamanhoService:
    def get_list(self):
        return EstoqueTamanhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return EstoqueTamanhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EstoqueTamanhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EstoqueTamanhoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EstoqueTamanhoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EstoqueTamanhoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()