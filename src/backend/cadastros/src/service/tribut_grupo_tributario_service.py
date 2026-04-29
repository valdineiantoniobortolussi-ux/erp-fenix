from src import db
from sqlalchemy import text
from src.model.tribut_grupo_tributario_model import TributGrupoTributarioModel

class TributGrupoTributarioService:
    def get_list(self):
        return TributGrupoTributarioModel.query.all()

    def get_list_filter(self, filter_obj):
        return TributGrupoTributarioModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return TributGrupoTributarioModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = TributGrupoTributarioModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = TributGrupoTributarioModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = TributGrupoTributarioModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()