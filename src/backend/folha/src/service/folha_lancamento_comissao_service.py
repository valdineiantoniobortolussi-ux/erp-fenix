from src import db
from sqlalchemy import text
from src.model.folha_lancamento_comissao_model import FolhaLancamentoComissaoModel

class FolhaLancamentoComissaoService:
    def get_list(self):
        return FolhaLancamentoComissaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaLancamentoComissaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaLancamentoComissaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaLancamentoComissaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaLancamentoComissaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaLancamentoComissaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()