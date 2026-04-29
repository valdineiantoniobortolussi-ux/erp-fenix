from src import db
from sqlalchemy import text
from src.model.centro_resultado_model import CentroResultadoModel
from src.model.ct_resultado_nt_financeira_model import CtResultadoNtFinanceiraModel

class CentroResultadoService:
    def get_list(self):
        return CentroResultadoModel.query.all()

    def get_list_filter(self, filter_obj):
        return CentroResultadoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CentroResultadoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CentroResultadoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CentroResultadoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CentroResultadoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # ctResultadoNtFinanceiraModel
        children_data = data.get('ctResultadoNtFinanceiraModelList', []) 
        for child_data in children_data:
            child = CtResultadoNtFinanceiraModel()
            child.mapping(child_data)
            parent.ct_resultado_nt_financeira_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # ctResultadoNtFinanceiraModel
        for child in parent.ct_resultado_nt_financeira_model_list: 
            db.session.delete(child)

