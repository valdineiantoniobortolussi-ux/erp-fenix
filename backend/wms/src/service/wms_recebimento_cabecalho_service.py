from src import db
from sqlalchemy import text
from src.model.wms_recebimento_cabecalho_model import WmsRecebimentoCabecalhoModel
from src.model.wms_recebimento_detalhe_model import WmsRecebimentoDetalheModel

class WmsRecebimentoCabecalhoService:
    def get_list(self):
        return WmsRecebimentoCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return WmsRecebimentoCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return WmsRecebimentoCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = WmsRecebimentoCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = WmsRecebimentoCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = WmsRecebimentoCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # wmsRecebimentoDetalheModel
        children_data = data.get('wmsRecebimentoDetalheModelList', []) 
        for child_data in children_data:
            child = WmsRecebimentoDetalheModel()
            child.mapping(child_data)
            parent.wms_recebimento_detalhe_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # wmsRecebimentoDetalheModel
        for child in parent.wms_recebimento_detalhe_model_list: 
            db.session.delete(child)

