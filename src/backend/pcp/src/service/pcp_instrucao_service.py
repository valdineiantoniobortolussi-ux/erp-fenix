from src import db
from sqlalchemy import text
from src.model.pcp_instrucao_model import PcpInstrucaoModel

class PcpInstrucaoService:
    def get_list(self):
        return PcpInstrucaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return PcpInstrucaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PcpInstrucaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PcpInstrucaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PcpInstrucaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PcpInstrucaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()