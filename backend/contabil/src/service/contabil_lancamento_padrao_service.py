from src import db
from sqlalchemy import text
from src.model.contabil_lancamento_padrao_model import ContabilLancamentoPadraoModel

class ContabilLancamentoPadraoService:
    def get_list(self):
        return ContabilLancamentoPadraoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilLancamentoPadraoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilLancamentoPadraoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilLancamentoPadraoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilLancamentoPadraoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilLancamentoPadraoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()