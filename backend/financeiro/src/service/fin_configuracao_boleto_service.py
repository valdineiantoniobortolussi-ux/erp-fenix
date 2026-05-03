from src import db
from sqlalchemy import text
from src.model.fin_configuracao_boleto_model import FinConfiguracaoBoletoModel

class FinConfiguracaoBoletoService:
    def get_list(self):
        return FinConfiguracaoBoletoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FinConfiguracaoBoletoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FinConfiguracaoBoletoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FinConfiguracaoBoletoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FinConfiguracaoBoletoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FinConfiguracaoBoletoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()