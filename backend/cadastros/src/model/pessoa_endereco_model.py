from src import db


class PessoaEnderecoModel(db.Model):
    __tablename__ = 'pessoa_endereco'

    id = db.Column(db.Integer, primary_key=True)
    logradouro = db.Column(db.String(100))
    numero = db.Column(db.String(10))
    complemento = db.Column(db.String(100))
    bairro = db.Column(db.String(100))
    cidade = db.Column(db.String(100))
    uf = db.Column(db.String(2))
    cep = db.Column(db.String(8))
    municipio_ibge = db.Column(db.Integer)
    principal = db.Column(db.String(1))
    entrega = db.Column(db.String(1))
    cobranca = db.Column(db.String(1))
    correspondencia = db.Column(db.String(1))
    id_pessoa = db.Column(db.Integer, db.ForeignKey('pessoa.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_pessoa = data.get('idPessoa')
        self.logradouro = data.get('logradouro')
        self.numero = data.get('numero')
        self.complemento = data.get('complemento')
        self.bairro = data.get('bairro')
        self.cidade = data.get('cidade')
        self.uf = data.get('uf')
        self.cep = data.get('cep')
        self.municipio_ibge = data.get('municipioIbge')
        self.principal = data.get('principal')
        self.entrega = data.get('entrega')
        self.cobranca = data.get('cobranca')
        self.correspondencia = data.get('correspondencia')

    def serialize(self):
        return {
            'id': self.id,
            'idPessoa': self.id_pessoa,
            'logradouro': self.logradouro,
            'numero': self.numero,
            'complemento': self.complemento,
            'bairro': self.bairro,
            'cidade': self.cidade,
            'uf': self.uf,
            'cep': self.cep,
            'municipioIbge': self.municipio_ibge,
            'principal': self.principal,
            'entrega': self.entrega,
            'cobranca': self.cobranca,
            'correspondencia': self.correspondencia,
        }