from src import db
from sqlalchemy import text
from src.model.contabil_historico_model import ContabilHistoricoModel

class ContabilHistoricoService:
    def get_list(self):
        return ContabilHistoricoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilHistoricoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilHistoricoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilHistoricoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilHistoricoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilHistoricoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()