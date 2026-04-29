from src import db
from sqlalchemy import text
from src.model.venda_orcamento_cabecalho_model import VendaOrcamentoCabecalhoModel
from src.model.venda_orcamento_detalhe_model import VendaOrcamentoDetalheModel

class VendaOrcamentoCabecalhoService:
    def get_list(self):
        return VendaOrcamentoCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return VendaOrcamentoCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return VendaOrcamentoCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = VendaOrcamentoCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = VendaOrcamentoCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = VendaOrcamentoCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # vendaOrcamentoDetalheModel
        children_data = data.get('vendaOrcamentoDetalheModelList', []) 
        for child_data in children_data:
            child = VendaOrcamentoDetalheModel()
            child.mapping(child_data)
            parent.venda_orcamento_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # vendaOrcamentoDetalheModel
        for child in parent.venda_orcamento_detalhe_model_list: 
            db.session.delete(child)

