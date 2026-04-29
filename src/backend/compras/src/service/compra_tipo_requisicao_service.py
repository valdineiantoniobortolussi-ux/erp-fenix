from src import db
from sqlalchemy import text
from src.model.compra_tipo_requisicao_model import CompraTipoRequisicaoModel

class CompraTipoRequisicaoService:
    def get_list(self):
        return CompraTipoRequisicaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return CompraTipoRequisicaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CompraTipoRequisicaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CompraTipoRequisicaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CompraTipoRequisicaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CompraTipoRequisicaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()