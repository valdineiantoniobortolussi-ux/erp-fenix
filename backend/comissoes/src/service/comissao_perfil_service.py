from src import db
from sqlalchemy import text
from src.model.comissao_perfil_model import ComissaoPerfilModel

class ComissaoPerfilService:
    def get_list(self):
        return ComissaoPerfilModel.query.all()

    def get_list_filter(self, filter_obj):
        return ComissaoPerfilModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ComissaoPerfilModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ComissaoPerfilModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ComissaoPerfilModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ComissaoPerfilModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()