from src import db
from sqlalchemy import text
from src.model.pessoa_model import PessoaModel
from src.model.pessoa_juridica_model import PessoaJuridicaModel
from src.model.fornecedor_model import FornecedorModel
from src.model.cliente_model import ClienteModel
from src.model.pessoa_fisica_model import PessoaFisicaModel
from src.model.transportadora_model import TransportadoraModel
from src.model.contador_model import ContadorModel
from src.model.pessoa_contato_model import PessoaContatoModel
from src.model.pessoa_telefone_model import PessoaTelefoneModel
from src.model.pessoa_endereco_model import PessoaEnderecoModel

class PessoaService:
    def get_list(self):
        return PessoaModel.query.all()

    def get_list_filter(self, filter_obj):
        return PessoaModel.query.filter(text(filter_obj.where)).all()

    def get_object(self, id):
        return PessoaModel.query.get_or_404(id)
    
    def insert(self, data):
        obj = PessoaModel()
        obj.mapping(data)
        with db.session.begin_nested():
            db.session.add(obj) 
            self.insert_children(data, obj)
        db.session.commit()  
        return obj

    def update(self, data):
        id = data.get('id')
        obj = PessoaModel.query.get_or_404(id)
        obj.mapping(data)
        with db.session.begin_nested():
            self.delete_children(obj)
            self.insert_children(data, obj)
        db.session.commit()
        return obj
    
    def delete(self, id):
        obj = PessoaModel.query.get_or_404(id)
        with db.session.begin_nested():
            self.delete_children(obj)
            db.session.delete(obj)
        db.session.commit()

    def insert_children(self, data, parent):
        # pessoaJuridicaModel
        child_data = data.get('pessoaJuridicaModel') 
        if child_data:
            child = PessoaJuridicaModel()
            child.mapping(child_data)
            parent.pessoa_juridica_model = child
            db.session.add(child)

        # fornecedorModel
        child_data = data.get('fornecedorModel') 
        if child_data:
            child = FornecedorModel()
            child.mapping(child_data)
            parent.fornecedor_model = child
            db.session.add(child)

        # clienteModel
        child_data = data.get('clienteModel') 
        if child_data:
            child = ClienteModel()
            child.mapping(child_data)
            parent.cliente_model = child
            db.session.add(child)

        # pessoaFisicaModel
        child_data = data.get('pessoaFisicaModel') 
        if child_data:
            child = PessoaFisicaModel()
            child.mapping(child_data)
            parent.pessoa_fisica_model = child
            db.session.add(child)

        # transportadoraModel
        child_data = data.get('transportadoraModel') 
        if child_data:
            child = TransportadoraModel()
            child.mapping(child_data)
            parent.transportadora_model = child
            db.session.add(child)

        # contadorModel
        child_data = data.get('contadorModel') 
        if child_data:
            child = ContadorModel()
            child.mapping(child_data)
            parent.contador_model = child
            db.session.add(child)

        # pessoaContatoModel
        children_data = data.get('pessoaContatoModelList', []) 
        for child_data in children_data:
            child = PessoaContatoModel()
            child.mapping(child_data)
            parent.pessoa_contato_model_list.append(child)
            db.session.add(child)

        # pessoaTelefoneModel
        children_data = data.get('pessoaTelefoneModelList', []) 
        for child_data in children_data:
            child = PessoaTelefoneModel()
            child.mapping(child_data)
            parent.pessoa_telefone_model_list.append(child)
            db.session.add(child)

        # pessoaEnderecoModel
        children_data = data.get('pessoaEnderecoModelList', []) 
        for child_data in children_data:
            child = PessoaEnderecoModel()
            child.mapping(child_data)
            parent.pessoa_endereco_model_list.append(child)
            db.session.add(child)


    def delete_children(self, parent):
        # pessoaJuridicaModel
        if parent.pessoa_juridica_model: 
            db.session.delete(parent.pessoa_juridica_model)

        # fornecedorModel
        if parent.fornecedor_model: 
            db.session.delete(parent.fornecedor_model)

        # clienteModel
        if parent.cliente_model: 
            db.session.delete(parent.cliente_model)

        # pessoaFisicaModel
        if parent.pessoa_fisica_model: 
            db.session.delete(parent.pessoa_fisica_model)

        # transportadoraModel
        if parent.transportadora_model: 
            db.session.delete(parent.transportadora_model)

        # contadorModel
        if parent.contador_model: 
            db.session.delete(parent.contador_model)

        # pessoaContatoModel
        for child in parent.pessoa_contato_model_list: 
            db.session.delete(child)

        # pessoaTelefoneModel
        for child in parent.pessoa_telefone_model_list: 
            db.session.delete(child)

        # pessoaEnderecoModel
        for child in parent.pessoa_endereco_model_list: 
            db.session.delete(child)

