from src import db
from sqlalchemy import text
from src.model.ponto_horario_model import PontoHorarioModel

class PontoHorarioService:
    def get_list(self):
        return PontoHorarioModel.query.all()

    def get_list_filter(self, filter_obj):
        return PontoHorarioModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PontoHorarioModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PontoHorarioModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PontoHorarioModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PontoHorarioModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()