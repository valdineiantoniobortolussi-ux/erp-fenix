from src import db
from sqlalchemy import text
from src.model.view_controle_acesso_model import ViewControleAcessoModel

class ViewControleAcessoService:
    def get_list(self):
        return ViewControleAcessoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ViewControleAcessoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ViewControleAcessoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ViewControleAcessoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ViewControleAcessoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ViewControleAcessoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()