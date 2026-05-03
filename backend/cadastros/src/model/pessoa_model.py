from src import db
from src.model.pessoa_juridica_model import PessoaJuridicaModel
from src.model.fornecedor_model import FornecedorModel
from src.model.cliente_model import ClienteModel
from src.model.pessoa_fisica_model import PessoaFisicaModel
from src.model.transportadora_model import TransportadoraModel
from src.model.contador_model import ContadorModel
from src.model.pessoa_contato_model import PessoaContatoModel
from src.model.pessoa_telefone_model import PessoaTelefoneModel
from src.model.pessoa_endereco_model import PessoaEnderecoModel


class PessoaModel(db.Model):
    __tablename__ = 'pessoa'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(150))
    tipo = db.Column(db.String(1))
    site = db.Column(db.String(250))
    email = db.Column(db.String(250))
    eh_cliente = db.Column(db.String(1))
    eh_fornecedor = db.Column(db.String(1))
    eh_transportadora = db.Column(db.String(1))
    eh_colaborador = db.Column(db.String(1))
    eh_contador = db.Column(db.String(1))

    pessoa_juridica_model = db.relationship('PessoaJuridicaModel', uselist=False)
    fornecedor_model = db.relationship('FornecedorModel', uselist=False)
    cliente_model = db.relationship('ClienteModel', uselist=False)
    pessoa_fisica_model = db.relationship('PessoaFisicaModel', uselist=False)
    transportadora_model = db.relationship('TransportadoraModel', uselist=False)
    contador_model = db.relationship('ContadorModel', uselist=False)
    pessoa_contato_model_list = db.relationship('PessoaContatoModel', lazy='dynamic')
    pessoa_telefone_model_list = db.relationship('PessoaTelefoneModel', lazy='dynamic')
    pessoa_endereco_model_list = db.relationship('PessoaEnderecoModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.tipo = data.get('tipo')
        self.site = data.get('site')
        self.email = data.get('email')
        self.eh_cliente = data.get('ehCliente')
        self.eh_fornecedor = data.get('ehFornecedor')
        self.eh_transportadora = data.get('ehTransportadora')
        self.eh_colaborador = data.get('ehColaborador')
        self.eh_contador = data.get('ehContador')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'tipo': self.tipo,
            'site': self.site,
            'email': self.email,
            'ehCliente': self.eh_cliente,
            'ehFornecedor': self.eh_fornecedor,
            'ehTransportadora': self.eh_transportadora,
            'ehColaborador': self.eh_colaborador,
            'ehContador': self.eh_contador,
            'pessoaJuridicaModel': self.pessoa_juridica_model.serialize() if self.pessoa_juridica_model else None,
            'fornecedorModel': self.fornecedor_model.serialize() if self.fornecedor_model else None,
            'clienteModel': self.cliente_model.serialize() if self.cliente_model else None,
            'pessoaFisicaModel': self.pessoa_fisica_model.serialize() if self.pessoa_fisica_model else None,
            'transportadoraModel': self.transportadora_model.serialize() if self.transportadora_model else None,
            'contadorModel': self.contador_model.serialize() if self.contador_model else None,
            'pessoaContatoModelList': [pessoa_contato_model.serialize() for pessoa_contato_model in self.pessoa_contato_model_list],
            'pessoaTelefoneModelList': [pessoa_telefone_model.serialize() for pessoa_telefone_model in self.pessoa_telefone_model_list],
            'pessoaEnderecoModelList': [pessoa_endereco_model.serialize() for pessoa_endereco_model in self.pessoa_endereco_model_list],
        }