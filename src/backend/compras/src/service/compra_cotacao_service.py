from src import db
from sqlalchemy import text
from src.model.compra_cotacao_model import CompraCotacaoModel
from src.model.compra_fornecedor_cotacao_model import CompraFornecedorCotacaoModel
from src.model.compra_cotacao_detalhe_model import CompraCotacaoDetalheModel

class CompraCotacaoService:
    def get_list(self):
        return CompraCotacaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return CompraCotacaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CompraCotacaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CompraCotacaoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CompraCotacaoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CompraCotacaoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # compraFornecedorCotacaoModel
        children_data = data.get('compraFornecedorCotacaoModelList', []) 
        for child_data in children_data:
            child = CompraFornecedorCotacaoModel()
            child.mapping(child_data)
            parent.compra_fornecedor_cotacao_model_list.append(child)
            db.session.add(child)

        # compraCotacaoDetalheModel
        children_data = data.get('compraCotacaoDetalheModelList', []) 
        for child_data in children_data:
            child = CompraCotacaoDetalheModel()
            child.mapping(child_data)
            parent.compra_cotacao_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # compraFornecedorCotacaoModel
        for child in parent.compra_fornecedor_cotacao_model_list: 
            db.session.delete(child)

        # compraCotacaoDetalheModel
        for child in parent.compra_cotacao_detalhe_model_list: 
            db.session.delete(child)

