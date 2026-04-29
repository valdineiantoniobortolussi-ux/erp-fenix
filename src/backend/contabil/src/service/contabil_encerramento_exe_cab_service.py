from src import db
from sqlalchemy import text
from src.model.contabil_encerramento_exe_cab_model import ContabilEncerramentoExeCabModel
from src.model.contabil_encerramento_exe_det_model import ContabilEncerramentoExeDetModel

class ContabilEncerramentoExeCabService:
    def get_list(self):
        return ContabilEncerramentoExeCabModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilEncerramentoExeCabModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilEncerramentoExeCabModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilEncerramentoExeCabModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilEncerramentoExeCabModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilEncerramentoExeCabModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # contabilEncerramentoExeDetModel
        children_data = data.get('contabilEncerramentoExeDetModelList', []) 
        for child_data in children_data:
            child = ContabilEncerramentoExeDetModel()
            child.mapping(child_data)
            parent.contabil_encerramento_exe_det_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # contabilEncerramentoExeDetModel
        for child in parent.contabil_encerramento_exe_det_model_list: 
            db.session.delete(child)

