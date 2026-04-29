from src import db
from sqlalchemy import text
from src.model.wms_ordem_separacao_cab_model import WmsOrdemSeparacaoCabModel
from src.model.wms_ordem_separacao_det_model import WmsOrdemSeparacaoDetModel

class WmsOrdemSeparacaoCabService:
    def get_list(self):
        return WmsOrdemSeparacaoCabModel.query.all()

    def get_list_filter(self, filter_obj):
        return WmsOrdemSeparacaoCabModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return WmsOrdemSeparacaoCabModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = WmsOrdemSeparacaoCabModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = WmsOrdemSeparacaoCabModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = WmsOrdemSeparacaoCabModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # wmsOrdemSeparacaoDetModel
        children_data = data.get('wmsOrdemSeparacaoDetModelList', []) 
        for child_data in children_data:
            child = WmsOrdemSeparacaoDetModel()
            child.mapping(child_data)
            parent.wms_ordem_separacao_det_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # wmsOrdemSeparacaoDetModel
        for child in parent.wms_ordem_separacao_det_model_list: 
            db.session.delete(child)

