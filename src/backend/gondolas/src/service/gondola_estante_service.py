from src import db
from sqlalchemy import text
from src.model.gondola_estante_model import GondolaEstanteModel

class GondolaEstanteService:
    def get_list(self):
        return GondolaEstanteModel.query.all()

    def get_list_filter(self, filter_obj):
        return GondolaEstanteModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return GondolaEstanteModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = GondolaEstanteModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = GondolaEstanteModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = GondolaEstanteModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()