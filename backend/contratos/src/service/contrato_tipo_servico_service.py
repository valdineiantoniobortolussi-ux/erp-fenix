from src import db
from sqlalchemy import text
from src.model.contrato_tipo_servico_model import ContratoTipoServicoModel

class ContratoTipoServicoService:
    def get_list(self):
        return ContratoTipoServicoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContratoTipoServicoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContratoTipoServicoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContratoTipoServicoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContratoTipoServicoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContratoTipoServicoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()