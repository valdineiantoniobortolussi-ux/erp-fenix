from src import db
from sqlalchemy import text
from src.model.talonario_cheque_model import TalonarioChequeModel
from src.model.cheque_model import ChequeModel

class TalonarioChequeService:
    def get_list(self):
        return TalonarioChequeModel.query.all()

    def get_list_filter(self, filter_obj):
        return TalonarioChequeModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return TalonarioChequeModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = TalonarioChequeModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = TalonarioChequeModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = TalonarioChequeModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # chequeModel
        children_data = data.get('chequeModelList', []) 
        for child_data in children_data:
            child = ChequeModel()
            child.mapping(child_data)
            parent.cheque_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # chequeModel
        for child in parent.cheque_model_list: 
            db.session.delete(child)

