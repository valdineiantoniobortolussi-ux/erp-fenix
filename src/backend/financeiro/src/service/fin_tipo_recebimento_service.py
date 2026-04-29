from src import db
from sqlalchemy import text
from src.model.fin_tipo_recebimento_model import FinTipoRecebimentoModel

class FinTipoRecebimentoService:
    def get_list(self):
        return FinTipoRecebimentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FinTipoRecebimentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FinTipoRecebimentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FinTipoRecebimentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FinTipoRecebimentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FinTipoRecebimentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()