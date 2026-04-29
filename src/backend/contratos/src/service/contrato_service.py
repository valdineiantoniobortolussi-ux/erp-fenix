from src import db
from sqlalchemy import text
from src.model.contrato_model import ContratoModel
from src.model.contrato_historico_reajuste_model import ContratoHistoricoReajusteModel
from src.model.contrato_prev_faturamento_model import ContratoPrevFaturamentoModel
from src.model.contrato_hist_faturamento_model import ContratoHistFaturamentoModel

class ContratoService:
    def get_list(self):
        return ContratoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContratoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContratoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContratoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContratoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContratoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # contratoHistoricoReajusteModel
        children_data = data.get('contratoHistoricoReajusteModelList', []) 
        for child_data in children_data:
            child = ContratoHistoricoReajusteModel()
            child.mapping(child_data)
            parent.contrato_historico_reajuste_model_list.append(child)
            db.session.add(child)

        # contratoPrevFaturamentoModel
        children_data = data.get('contratoPrevFaturamentoModelList', []) 
        for child_data in children_data:
            child = ContratoPrevFaturamentoModel()
            child.mapping(child_data)
            parent.contrato_prev_faturamento_model_list.append(child)
            db.session.add(child)

        # contratoHistFaturamentoModel
        children_data = data.get('contratoHistFaturamentoModelList', []) 
        for child_data in children_data:
            child = ContratoHistFaturamentoModel()
            child.mapping(child_data)
            parent.contrato_hist_faturamento_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # contratoHistoricoReajusteModel
        for child in parent.contrato_historico_reajuste_model_list: 
            db.session.delete(child)

        # contratoPrevFaturamentoModel
        for child in parent.contrato_prev_faturamento_model_list: 
            db.session.delete(child)

        # contratoHistFaturamentoModel
        for child in parent.contrato_hist_faturamento_model_list: 
            db.session.delete(child)

