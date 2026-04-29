from src import db
from sqlalchemy import text
from src.model.orcamento_periodo_model import OrcamentoPeriodoModel

class OrcamentoPeriodoService:
    def get_list(self):
        return OrcamentoPeriodoModel.query.all()

    def get_list_filter(self, filter_obj):
        return OrcamentoPeriodoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return OrcamentoPeriodoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = OrcamentoPeriodoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = OrcamentoPeriodoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = OrcamentoPeriodoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()