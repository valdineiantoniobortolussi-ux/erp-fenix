from src import db
from sqlalchemy import text
from src.model.tipo_relacionamento_model import TipoRelacionamentoModel

class TipoRelacionamentoService:
    def get_list(self):
        return TipoRelacionamentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return TipoRelacionamentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return TipoRelacionamentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = TipoRelacionamentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = TipoRelacionamentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = TipoRelacionamentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()