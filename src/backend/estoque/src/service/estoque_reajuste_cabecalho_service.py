from src import db
from sqlalchemy import text
from src.model.estoque_reajuste_cabecalho_model import EstoqueReajusteCabecalhoModel
from src.model.estoque_reajuste_detalhe_model import EstoqueReajusteDetalheModel

class EstoqueReajusteCabecalhoService:
    def get_list(self):
        return EstoqueReajusteCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return EstoqueReajusteCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EstoqueReajusteCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EstoqueReajusteCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EstoqueReajusteCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EstoqueReajusteCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # estoqueReajusteDetalheModel
        children_data = data.get('estoqueReajusteDetalheModelList', []) 
        for child_data in children_data:
            child = EstoqueReajusteDetalheModel()
            child.mapping(child_data)
            parent.estoque_reajuste_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # estoqueReajusteDetalheModel
        for child in parent.estoque_reajuste_detalhe_model_list: 
            db.session.delete(child)

