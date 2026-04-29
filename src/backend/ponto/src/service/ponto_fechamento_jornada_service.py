from src import db
from sqlalchemy import text
from src.model.ponto_fechamento_jornada_model import PontoFechamentoJornadaModel

class PontoFechamentoJornadaService:
    def get_list(self):
        return PontoFechamentoJornadaModel.query.all()

    def get_list_filter(self, filter_obj):
        return PontoFechamentoJornadaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PontoFechamentoJornadaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PontoFechamentoJornadaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PontoFechamentoJornadaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PontoFechamentoJornadaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()