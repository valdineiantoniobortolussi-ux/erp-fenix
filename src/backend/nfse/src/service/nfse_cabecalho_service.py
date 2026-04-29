from src import db
from sqlalchemy import text
from src.model.nfse_cabecalho_model import NfseCabecalhoModel
from src.model.nfse_detalhe_model import NfseDetalheModel
from src.model.nfse_intermediario_model import NfseIntermediarioModel

class NfseCabecalhoService:
    def get_list(self):
        return NfseCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return NfseCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return NfseCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = NfseCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = NfseCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = NfseCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # nfseDetalheModel
        children_data = data.get('nfseDetalheModelList', []) 
        for child_data in children_data:
            child = NfseDetalheModel()
            child.mapping(child_data)
            parent.nfse_detalhe_model_list.append(child)
            db.session.add(child)

        # nfseIntermediarioModel
        children_data = data.get('nfseIntermediarioModelList', []) 
        for child_data in children_data:
            child = NfseIntermediarioModel()
            child.mapping(child_data)
            parent.nfse_intermediario_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # nfseDetalheModel
        for child in parent.nfse_detalhe_model_list: 
            db.session.delete(child)

        # nfseIntermediarioModel
        for child in parent.nfse_intermediario_model_list: 
            db.session.delete(child)

