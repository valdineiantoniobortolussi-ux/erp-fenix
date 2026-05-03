from src import db
from sqlalchemy import text
from src.model.cte_informacao_nf_transporte_model import CteInformacaoNfTransporteModel

class CteInformacaoNfTransporteService:
    def get_list(self):
        return CteInformacaoNfTransporteModel.query.all()

    def get_list_filter(self, filter_obj):
        return CteInformacaoNfTransporteModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return CteInformacaoNfTransporteModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = CteInformacaoNfTransporteModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = CteInformacaoNfTransporteModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = CteInformacaoNfTransporteModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()