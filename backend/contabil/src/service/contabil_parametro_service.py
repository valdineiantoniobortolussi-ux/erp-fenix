from src import db
from sqlalchemy import text
from src.model.contabil_parametro_model import ContabilParametroModel

class ContabilParametroService:
    def get_list(self):
        return ContabilParametroModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContabilParametroModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContabilParametroModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContabilParametroModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContabilParametroModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContabilParametroModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()