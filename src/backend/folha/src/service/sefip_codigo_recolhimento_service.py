from src import db
from sqlalchemy import text
from src.model.sefip_codigo_recolhimento_model import SefipCodigoRecolhimentoModel

class SefipCodigoRecolhimentoService:
    def get_list(self):
        return SefipCodigoRecolhimentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return SefipCodigoRecolhimentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return SefipCodigoRecolhimentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = SefipCodigoRecolhimentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = SefipCodigoRecolhimentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = SefipCodigoRecolhimentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()