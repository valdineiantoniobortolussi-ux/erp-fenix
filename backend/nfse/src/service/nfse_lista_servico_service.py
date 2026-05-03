from src import db
from sqlalchemy import text
from src.model.nfse_lista_servico_model import NfseListaServicoModel

class NfseListaServicoService:
    def get_list(self):
        return NfseListaServicoModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfseListaServicoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfseListaServicoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfseListaServicoModel()
        obj.mapping(data)
        db.session.add(obj)
        db.session.commit()
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfseListaServicoModel.query.get_or_404(id)
        obj.mapping(data)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfseListaServicoModel.query.get_or_404(id)
        db.session.delete(obj)
        db.session.commit()