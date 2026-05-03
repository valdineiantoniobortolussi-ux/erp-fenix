from src import db
from sqlalchemy import text
from src.model.contabil_dre_cabecalho_model import ContabilDreCabecalhoModel
from src.model.contabil_dre_detalhe_model import ContabilDreDetalheModel

class ContabilDreCabecalhoService:
    def get_list(self):
        return ContabilDreCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilDreCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilDreCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilDreCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilDreCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilDreCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # contabilDreDetalheModel
        children_data = data.get('contabilDreDetalheModelList', []) 
        for child_data in children_data:
            child = ContabilDreDetalheModel()
            child.mapping(child_data)
            parent.contabil_dre_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # contabilDreDetalheModel
        for child in parent.contabil_dre_detalhe_model_list: 
            db.session.delete(child)

