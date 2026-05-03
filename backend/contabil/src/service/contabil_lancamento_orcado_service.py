from src import db
from sqlalchemy import text
from src.model.contabil_lancamento_orcado_model import ContabilLancamentoOrcadoModel

class ContabilLancamentoOrcadoService:
    def get_list(self):
        return ContabilLancamentoOrcadoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilLancamentoOrcadoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilLancamentoOrcadoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilLancamentoOrcadoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilLancamentoOrcadoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilLancamentoOrcadoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()