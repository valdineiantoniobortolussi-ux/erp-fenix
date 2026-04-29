from src import db
from sqlalchemy import text
from src.model.contrato_template_model import ContratoTemplateModel

class ContratoTemplateService:
    def get_list(self):
        return ContratoTemplateModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContratoTemplateModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContratoTemplateModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContratoTemplateModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContratoTemplateModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContratoTemplateModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()