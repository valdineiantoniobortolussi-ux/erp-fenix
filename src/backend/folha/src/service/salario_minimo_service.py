from src import db
from sqlalchemy import text
from src.model.salario_minimo_model import SalarioMinimoModel

class SalarioMinimoService:
    def get_list(self):
        return SalarioMinimoModel.query.all()

    def get_list_filter(self, filter_obj):
        return SalarioMinimoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return SalarioMinimoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = SalarioMinimoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = SalarioMinimoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = SalarioMinimoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()