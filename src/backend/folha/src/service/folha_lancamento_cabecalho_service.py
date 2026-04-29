from src import db
from sqlalchemy import text
from src.model.folha_lancamento_cabecalho_model import FolhaLancamentoCabecalhoModel
from src.model.folha_lancamento_detalhe_model import FolhaLancamentoDetalheModel

class FolhaLancamentoCabecalhoService:
    def get_list(self):
        return FolhaLancamentoCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaLancamentoCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaLancamentoCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaLancamentoCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaLancamentoCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaLancamentoCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # folhaLancamentoDetalheModel
        children_data = data.get('folhaLancamentoDetalheModelList', []) 
        for child_data in children_data:
            child = FolhaLancamentoDetalheModel()
            child.mapping(child_data)
            parent.folha_lancamento_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # folhaLancamentoDetalheModel
        for child in parent.folha_lancamento_detalhe_model_list: 
            db.session.delete(child)

