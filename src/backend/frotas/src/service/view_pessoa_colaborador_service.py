from src import db
from sqlalchemy import text
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel

class ViewPessoaColaboradorService:
    def get_list(self):
        return ViewPessoaColaboradorModel.query.all()

    def get_list_filter(self, filter_obj):
        return ViewPessoaColaboradorModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ViewPessoaColaboradorModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ViewPessoaColaboradorModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ViewPessoaColaboradorModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ViewPessoaColaboradorModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()