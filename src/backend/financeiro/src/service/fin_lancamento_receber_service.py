from src import db
from sqlalchemy import text
from src.model.fin_lancamento_receber_model import FinLancamentoReceberModel
from src.model.fin_parcela_receber_model import FinParcelaReceberModel

class FinLancamentoReceberService:
    def get_list(self):
        return FinLancamentoReceberModel.query.all()

    def get_list_filter(self, filter_obj):
        return FinLancamentoReceberModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FinLancamentoReceberModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FinLancamentoReceberModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FinLancamentoReceberModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FinLancamentoReceberModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # finParcelaReceberModel
        children_data = data.get('finParcelaReceberModelList', []) 
        for child_data in children_data:
            child = FinParcelaReceberModel()
            child.mapping(child_data)
            parent.fin_parcela_receber_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # finParcelaReceberModel
        for child in parent.fin_parcela_receber_model_list: 
            db.session.delete(child)

