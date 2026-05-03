from src import db
from sqlalchemy import text
from src.model.ponto_horario_autorizado_model import PontoHorarioAutorizadoModel

class PontoHorarioAutorizadoService:
    def get_list(self):
        return PontoHorarioAutorizadoModel.query.all()

    def get_list_filter(self, filter_obj):
        return PontoHorarioAutorizadoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PontoHorarioAutorizadoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PontoHorarioAutorizadoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PontoHorarioAutorizadoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PontoHorarioAutorizadoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()