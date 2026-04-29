from src import db
from sqlalchemy import text
from src.model.ponto_escala_model import PontoEscalaModel
from src.model.ponto_turma_model import PontoTurmaModel

class PontoEscalaService:
    def get_list(self):
        return PontoEscalaModel.query.all()

    def get_list_filter(self, filter_obj):
        return PontoEscalaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PontoEscalaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PontoEscalaModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PontoEscalaModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PontoEscalaModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # pontoTurmaModel
        children_data = data.get('pontoTurmaModelList', []) 
        for child_data in children_data:
            child = PontoTurmaModel()
            child.mapping(child_data)
            parent.ponto_turma_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # pontoTurmaModel
        for child in parent.ponto_turma_model_list: 
            db.session.delete(child)

