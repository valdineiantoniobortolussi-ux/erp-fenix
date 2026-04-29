from src import db
from sqlalchemy import text
from src.model.contabil_lancamento_cabecalho_model import ContabilLancamentoCabecalhoModel
from src.model.contabil_lancamento_detalhe_model import ContabilLancamentoDetalheModel

class ContabilLancamentoCabecalhoService:
    def get_list(self):
        return ContabilLancamentoCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilLancamentoCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilLancamentoCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilLancamentoCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilLancamentoCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilLancamentoCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # contabilLancamentoDetalheModel
        children_data = data.get('contabilLancamentoDetalheModelList', []) 
        for child_data in children_data:
            child = ContabilLancamentoDetalheModel()
            child.mapping(child_data)
            parent.contabil_lancamento_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # contabilLancamentoDetalheModel
        for child in parent.contabil_lancamento_detalhe_model_list: 
            db.session.delete(child)

