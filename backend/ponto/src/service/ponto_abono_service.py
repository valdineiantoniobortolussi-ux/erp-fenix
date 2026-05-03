from src import db
from sqlalchemy import text
from src.model.ponto_abono_model import PontoAbonoModel
from src.model.ponto_abono_utilizacao_model import PontoAbonoUtilizacaoModel

class PontoAbonoService:
    def get_list(self):
        return PontoAbonoModel.query.all()

    def get_list_filter(self, filter_obj):
        return PontoAbonoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PontoAbonoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PontoAbonoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PontoAbonoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PontoAbonoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # pontoAbonoUtilizacaoModel
        children_data = data.get('pontoAbonoUtilizacaoModelList', []) 
        for child_data in children_data:
            child = PontoAbonoUtilizacaoModel()
            child.mapping(child_data)
            parent.ponto_abono_utilizacao_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # pontoAbonoUtilizacaoModel
        for child in parent.ponto_abono_utilizacao_model_list: 
            db.session.delete(child)

