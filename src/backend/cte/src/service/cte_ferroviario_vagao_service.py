from src import db
from sqlalchemy import text
from src.model.cte_ferroviario_vagao_model import CteFerroviarioVagaoModel

class CteFerroviarioVagaoService:
    def get_list(self):
        return CteFerroviarioVagaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return CteFerroviarioVagaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CteFerroviarioVagaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CteFerroviarioVagaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CteFerroviarioVagaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CteFerroviarioVagaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()