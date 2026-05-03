from src import db
from sqlalchemy import text
from src.model.fiscal_parametro_model import FiscalParametroModel
from src.model.fiscal_inscricoes_substitutas_model import FiscalInscricoesSubstitutasModel

class FiscalParametroService:
    def get_list(self):
        return FiscalParametroModel.query.all()

    def get_list_filter(self, filter_obj):
        return FiscalParametroModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FiscalParametroModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FiscalParametroModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FiscalParametroModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FiscalParametroModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # fiscalInscricoesSubstitutasModel
        children_data = data.get('fiscalInscricoesSubstitutasModelList', []) 
        for child_data in children_data:
            child = FiscalInscricoesSubstitutasModel()
            child.mapping(child_data)
            parent.fiscal_inscricoes_substitutas_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # fiscalInscricoesSubstitutasModel
        for child in parent.fiscal_inscricoes_substitutas_model_list: 
            db.session.delete(child)

