from src import db
from sqlalchemy import text
from src.model.operadora_plano_saude_model import OperadoraPlanoSaudeModel

class OperadoraPlanoSaudeService:
    def get_list(self):
        return OperadoraPlanoSaudeModel.query.all()

    def get_list_filter(self, filter_obj):
        return OperadoraPlanoSaudeModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return OperadoraPlanoSaudeModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = OperadoraPlanoSaudeModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = OperadoraPlanoSaudeModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = OperadoraPlanoSaudeModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()