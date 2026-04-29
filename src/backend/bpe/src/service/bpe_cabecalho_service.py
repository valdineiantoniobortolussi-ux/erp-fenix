from src import db
from sqlalchemy import text
from src.model.bpe_cabecalho_model import BpeCabecalhoModel
from src.model.bpe_emitente_model import BpeEmitenteModel
from src.model.bpe_passageiro_model import BpePassageiroModel
from src.model.bpe_comprador_model import BpeCompradorModel
from src.model.bpe_viagem_model import BpeViagemModel
from src.model.bpe_agencia_model import BpeAgenciaModel
from src.model.bpe_passagem_model import BpePassagemModel

class BpeCabecalhoService:
    def get_list(self):
        return BpeCabecalhoModel.query.all()

    def get_list_filter(self, filter_obj):
        return BpeCabecalhoModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return BpeCabecalhoModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = BpeCabecalhoModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = BpeCabecalhoModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = BpeCabecalhoModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # bpeEmitenteModel
        children_data = data.get('bpeEmitenteModelList', []) 
        for child_data in children_data:
            child = BpeEmitenteModel()
            child.mapping(child_data)
            parent.bpe_emitente_model_list.append(child)
            db.session.add(child)

        # bpePassageiroModel
        children_data = data.get('bpePassageiroModelList', []) 
        for child_data in children_data:
            child = BpePassageiroModel()
            child.mapping(child_data)
            parent.bpe_passageiro_model_list.append(child)
            db.session.add(child)

        # bpeCompradorModel
        children_data = data.get('bpeCompradorModelList', []) 
        for child_data in children_data:
            child = BpeCompradorModel()
            child.mapping(child_data)
            parent.bpe_comprador_model_list.append(child)
            db.session.add(child)

        # bpeViagemModel
        children_data = data.get('bpeViagemModelList', []) 
        for child_data in children_data:
            child = BpeViagemModel()
            child.mapping(child_data)
            parent.bpe_viagem_model_list.append(child)
            db.session.add(child)

        # bpeAgenciaModel
        children_data = data.get('bpeAgenciaModelList', []) 
        for child_data in children_data:
            child = BpeAgenciaModel()
            child.mapping(child_data)
            parent.bpe_agencia_model_list.append(child)
            db.session.add(child)

        # bpePassagemModel
        children_data = data.get('bpePassagemModelList', []) 
        for child_data in children_data:
            child = BpePassagemModel()
            child.mapping(child_data)
            parent.bpe_passagem_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # bpeEmitenteModel
        for child in parent.bpe_emitente_model_list: 
            db.session.delete(child)

        # bpePassageiroModel
        for child in parent.bpe_passageiro_model_list: 
            db.session.delete(child)

        # bpeCompradorModel
        for child in parent.bpe_comprador_model_list: 
            db.session.delete(child)

        # bpeViagemModel
        for child in parent.bpe_viagem_model_list: 
            db.session.delete(child)

        # bpeAgenciaModel
        for child in parent.bpe_agencia_model_list: 
            db.session.delete(child)

        # bpePassagemModel
        for child in parent.bpe_passagem_model_list: 
            db.session.delete(child)

