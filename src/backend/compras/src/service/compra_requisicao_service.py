from src import db
from sqlalchemy import text
from src.model.compra_requisicao_model import CompraRequisicaoModel
from src.model.compra_requisicao_detalhe_model import CompraRequisicaoDetalheModel

class CompraRequisicaoService:
    def get_list(self):
        return CompraRequisicaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return CompraRequisicaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CompraRequisicaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CompraRequisicaoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CompraRequisicaoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CompraRequisicaoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # compraRequisicaoDetalheModel
        children_data = data.get('compraRequisicaoDetalheModelList', []) 
        for child_data in children_data:
            child = CompraRequisicaoDetalheModel()
            child.mapping(child_data)
            parent.compra_requisicao_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # compraRequisicaoDetalheModel
        for child in parent.compra_requisicao_detalhe_model_list: 
            db.session.delete(child)

