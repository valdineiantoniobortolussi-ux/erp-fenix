from src import db
from sqlalchemy import text
from src.model.folha_tipo_afastamento_model import FolhaTipoAfastamentoModel

class FolhaTipoAfastamentoService:
    def get_list(self):
        return FolhaTipoAfastamentoModel.query.all()

    def get_list_filter(self, filter_obj):
        return FolhaTipoAfastamentoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return FolhaTipoAfastamentoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = FolhaTipoAfastamentoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = FolhaTipoAfastamentoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = FolhaTipoAfastamentoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()