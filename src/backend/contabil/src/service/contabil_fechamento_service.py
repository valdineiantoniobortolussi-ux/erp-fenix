from src import db
from sqlalchemy import text
from src.model.contabil_fechamento_model import ContabilFechamentoModel

class ContabilFechamentoService:
    def get_list(self):
        return ContabilFechamentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilFechamentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilFechamentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilFechamentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilFechamentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilFechamentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()