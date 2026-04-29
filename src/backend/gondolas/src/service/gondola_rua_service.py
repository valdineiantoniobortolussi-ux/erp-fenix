from src import db
from sqlalchemy import text
from src.model.gondola_rua_model import GondolaRuaModel

class GondolaRuaService:
    def get_list(self):
        return GondolaRuaModel.query.all()

    def get_list_filter(self, filter_obj):
        return GondolaRuaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return GondolaRuaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = GondolaRuaModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = GondolaRuaModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = GondolaRuaModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()