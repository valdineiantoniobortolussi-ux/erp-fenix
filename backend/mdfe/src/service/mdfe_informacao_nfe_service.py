from src import db
from sqlalchemy import text
from src.model.mdfe_informacao_nfe_model import MdfeInformacaoNfeModel

class MdfeInformacaoNfeService:
    def get_list(self):
        return MdfeInformacaoNfeModel.query.all()

    def get_list_filter(self, filter_obj):
        return MdfeInformacaoNfeModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return MdfeInformacaoNfeModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = MdfeInformacaoNfeModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = MdfeInformacaoNfeModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = MdfeInformacaoNfeModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()