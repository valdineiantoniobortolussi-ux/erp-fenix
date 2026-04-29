from src import db
from sqlalchemy import text
from src.model.view_pessoa_cliente_model import ViewPessoaClienteModel

class ViewPessoaClienteService:
    def get_list(self):
        return ViewPessoaClienteModel.query.all()

    def get_list_filter(self, filter_obj):
        return ViewPessoaClienteModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ViewPessoaClienteModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ViewPessoaClienteModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ViewPessoaClienteModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ViewPessoaClienteModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()