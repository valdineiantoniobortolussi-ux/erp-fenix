from src import db
from sqlalchemy import text
from src.model.orcamento_fluxo_caixa_model import OrcamentoFluxoCaixaModel
from src.model.orcamento_fluxo_caixa_detalhe_model import OrcamentoFluxoCaixaDetalheModel

class OrcamentoFluxoCaixaService:
    def get_list(self):
        return OrcamentoFluxoCaixaModel.query.all()

    def get_list_filter(self, filter_obj):
        return OrcamentoFluxoCaixaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return OrcamentoFluxoCaixaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = OrcamentoFluxoCaixaModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = OrcamentoFluxoCaixaModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = OrcamentoFluxoCaixaModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # orcamentoFluxoCaixaDetalheModel
        children_data = data.get('orcamentoFluxoCaixaDetalheModelList', []) 
        for child_data in children_data:
            child = OrcamentoFluxoCaixaDetalheModel()
            child.mapping(child_data)
            parent.orcamento_fluxo_caixa_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # orcamentoFluxoCaixaDetalheModel
        for child in parent.orcamento_fluxo_caixa_detalhe_model_list: 
            db.session.delete(child)

