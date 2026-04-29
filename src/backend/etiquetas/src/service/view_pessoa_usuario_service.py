from src import db
from sqlalchemy import text
from src.model.view_pessoa_usuario_model import ViewPessoaUsuarioModel

class ViewPessoaUsuarioService:
    def get_list(self):
        return ViewPessoaUsuarioModel.query.all()

    def get_list_filter(self, filter_obj):
        return ViewPessoaUsuarioModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ViewPessoaUsuarioModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ViewPessoaUsuarioModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ViewPessoaUsuarioModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ViewPessoaUsuarioModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()