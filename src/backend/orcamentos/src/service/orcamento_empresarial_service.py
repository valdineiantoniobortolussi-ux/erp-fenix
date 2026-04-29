from src import db
from sqlalchemy import text
from src.model.orcamento_empresarial_model import OrcamentoEmpresarialModel
from src.model.orcamento_detalhe_model import OrcamentoDetalheModel

class OrcamentoEmpresarialService:
    def get_list(self):
        return OrcamentoEmpresarialModel.query.all()

    def get_list_filter(self, filter_obj):
        return OrcamentoEmpresarialModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return OrcamentoEmpresarialModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = OrcamentoEmpresarialModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = OrcamentoEmpresarialModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = OrcamentoEmpresarialModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # orcamentoDetalheModel
        children_data = data.get('orcamentoDetalheModelList', []) 
        for child_data in children_data:
            child = OrcamentoDetalheModel()
            child.mapping(child_data)
            parent.orcamento_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # orcamentoDetalheModel
        for child in parent.orcamento_detalhe_model_list: 
            db.session.delete(child)

