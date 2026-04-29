from src import db
from sqlalchemy import text
from src.model.cte_ferroviario_ferrovia_model import CteFerroviarioFerroviaModel

class CteFerroviarioFerroviaService:
    def get_list(self):
        return CteFerroviarioFerroviaModel.query.all()

    def get_list_filter(self, filter_obj):
        return CteFerroviarioFerroviaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CteFerroviarioFerroviaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CteFerroviarioFerroviaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CteFerroviarioFerroviaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CteFerroviarioFerroviaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()