from src import db
from sqlalchemy import text
from src.model.esocial_motivo_desligamento_model import EsocialMotivoDesligamentoModel

class EsocialMotivoDesligamentoService:
    def get_list(self):
        return EsocialMotivoDesligamentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return EsocialMotivoDesligamentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return EsocialMotivoDesligamentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = EsocialMotivoDesligamentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = EsocialMotivoDesligamentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = EsocialMotivoDesligamentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()