from src import db
from sqlalchemy import text
from src.model.wms_agendamento_model import WmsAgendamentoModel

class WmsAgendamentoService:
    def get_list(self):
        return WmsAgendamentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return WmsAgendamentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return WmsAgendamentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = WmsAgendamentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = WmsAgendamentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = WmsAgendamentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()