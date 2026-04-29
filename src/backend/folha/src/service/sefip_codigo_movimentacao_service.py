from src import db
from sqlalchemy import text
from src.model.sefip_codigo_movimentacao_model import SefipCodigoMovimentacaoModel

class SefipCodigoMovimentacaoService:
    def get_list(self):
        return SefipCodigoMovimentacaoModel.query.all()

    def get_list_filter(self, filter_obj):
        return SefipCodigoMovimentacaoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return SefipCodigoMovimentacaoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = SefipCodigoMovimentacaoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = SefipCodigoMovimentacaoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = SefipCodigoMovimentacaoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()