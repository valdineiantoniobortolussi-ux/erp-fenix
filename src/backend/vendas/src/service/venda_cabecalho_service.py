from src import db
from sqlalchemy import text
from src.model.venda_cabecalho_model import VendaCabecalhoModel
from src.model.venda_comissao_model import VendaComissaoModel
from src.model.venda_detalhe_model import VendaDetalheModel
from src.model.venda_frete_model import VendaFreteModel

class VendaCabecalhoService:
    def get_list(self):
        return VendaCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return VendaCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return VendaCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = VendaCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = VendaCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = VendaCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # vendaComissaoModel
        child_data = data.get('vendaComissaoModel') 
        if child_data:
            child = VendaComissaoModel()
            child.mapping(child_data)
            parent.venda_comissao_model = child
            db.session.add(child)

        # vendaDetalheModel
        children_data = data.get('vendaDetalheModelList', []) 
        for child_data in children_data:
            child = VendaDetalheModel()
            child.mapping(child_data)
            parent.venda_detalhe_model_list.append(child)
            db.session.add(child)

        # vendaFreteModel
        children_data = data.get('vendaFreteModelList', []) 
        for child_data in children_data:
            child = VendaFreteModel()
            child.mapping(child_data)
            parent.venda_frete_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # vendaComissaoModel
        if parent.venda_comissao_model: 
            db.session.delete(parent.venda_comissao_model)

        # vendaDetalheModel
        for child in parent.venda_detalhe_model_list: 
            db.session.delete(child)

        # vendaFreteModel
        for child in parent.venda_frete_model_list: 
            db.session.delete(child)

