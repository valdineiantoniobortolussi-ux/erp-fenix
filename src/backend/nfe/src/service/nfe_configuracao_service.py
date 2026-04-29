from src import db
from sqlalchemy import text
from src.model.nfe_configuracao_model import NfeConfiguracaoModel

class NfeConfiguracaoService:
    def get_list(self):
        return NfeConfiguracaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfeConfiguracaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfeConfiguracaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfeConfiguracaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfeConfiguracaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfeConfiguracaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()