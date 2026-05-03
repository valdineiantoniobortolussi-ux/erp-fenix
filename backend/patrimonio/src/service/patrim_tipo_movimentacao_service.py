from src import db
from sqlalchemy import text
from src.model.patrim_tipo_movimentacao_model import PatrimTipoMovimentacaoModel

class PatrimTipoMovimentacaoService:
    def get_list(self):
        return PatrimTipoMovimentacaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return PatrimTipoMovimentacaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PatrimTipoMovimentacaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PatrimTipoMovimentacaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PatrimTipoMovimentacaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PatrimTipoMovimentacaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()