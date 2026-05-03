from src import db
from sqlalchemy import text
from src.model.contrato_solicitacao_servico_model import ContratoSolicitacaoServicoModel

class ContratoSolicitacaoServicoService:
    def get_list(self):
        return ContratoSolicitacaoServicoModel.query.all()

    def get_list_filter(self, filter_obj):
        return ContratoSolicitacaoServicoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return ContratoSolicitacaoServicoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = ContratoSolicitacaoServicoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = ContratoSolicitacaoServicoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = ContratoSolicitacaoServicoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()