from src import db
from sqlalchemy import text
from src.model.mdfe_informacao_cte_model import MdfeInformacaoCteModel

class MdfeInformacaoCteService:
    def get_list(self):
        return MdfeInformacaoCteModel.query.all()

    def get_list_filter(self, filter_obj):
        return MdfeInformacaoCteModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return MdfeInformacaoCteModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = MdfeInformacaoCteModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = MdfeInformacaoCteModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = MdfeInformacaoCteModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()