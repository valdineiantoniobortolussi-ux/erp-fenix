from src import db
from sqlalchemy import text
from src.model.folha_inss_servico_model import FolhaInssServicoModel

class FolhaInssServicoService:
    def get_list(self):
        return FolhaInssServicoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaInssServicoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaInssServicoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaInssServicoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaInssServicoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaInssServicoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()