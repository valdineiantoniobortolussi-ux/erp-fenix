from src import db
from sqlalchemy import text
from src.model.tipo_admissao_model import TipoAdmissaoModel

class TipoAdmissaoService:
    def get_list(self):
        return TipoAdmissaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return TipoAdmissaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return TipoAdmissaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = TipoAdmissaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = TipoAdmissaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = TipoAdmissaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()