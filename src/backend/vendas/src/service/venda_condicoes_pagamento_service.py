from src import db
from sqlalchemy import text
from src.model.venda_condicoes_pagamento_model import VendaCondicoesPagamentoModel
from src.model.venda_condicoes_parcelas_model import VendaCondicoesParcelasModel

class VendaCondicoesPagamentoService:
    def get_list(self):
        return VendaCondicoesPagamentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return VendaCondicoesPagamentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return VendaCondicoesPagamentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = VendaCondicoesPagamentoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = VendaCondicoesPagamentoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = VendaCondicoesPagamentoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # vendaCondicoesParcelasModel
        children_data = data.get('vendaCondicoesParcelasModelList', []) 
        for child_data in children_data:
            child = VendaCondicoesParcelasModel()
            child.mapping(child_data)
            parent.venda_condicoes_parcelas_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # vendaCondicoesParcelasModel
        for child in parent.venda_condicoes_parcelas_model_list: 
            db.session.delete(child)

