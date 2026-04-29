from src import db
from sqlalchemy import text
from src.model.estoque_grade_model import EstoqueGradeModel

class EstoqueGradeService:
    def get_list(self):
        return EstoqueGradeModel.query.all()

    def get_list_filter(self, filter_obj):
        return EstoqueGradeModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EstoqueGradeModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EstoqueGradeModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EstoqueGradeModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EstoqueGradeModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()