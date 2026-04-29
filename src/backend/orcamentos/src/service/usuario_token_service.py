from src import db
from sqlalchemy import text
from src.model.usuario_token_model import UsuarioTokenModel

class UsuarioTokenService:
    def get_list(self):
        return UsuarioTokenModel.query.all()

    def get_list_filter(self, filter_obj):
        return UsuarioTokenModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return UsuarioTokenModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = UsuarioTokenModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = UsuarioTokenModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = UsuarioTokenModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()