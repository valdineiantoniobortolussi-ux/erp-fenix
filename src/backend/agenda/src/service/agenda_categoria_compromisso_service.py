from src import db
from sqlalchemy import text
from src.model.agenda_categoria_compromisso_model import AgendaCategoriaCompromissoModel

class AgendaCategoriaCompromissoService:
    def get_list(self):
        return AgendaCategoriaCompromissoModel.query.all()

    def get_list_filter(self, filter_obj):
        return AgendaCategoriaCompromissoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return AgendaCategoriaCompromissoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = AgendaCategoriaCompromissoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = AgendaCategoriaCompromissoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = AgendaCategoriaCompromissoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()