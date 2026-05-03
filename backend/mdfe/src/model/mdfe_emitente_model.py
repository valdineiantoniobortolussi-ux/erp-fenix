from src import db


class MdfeEmitenteModel(db.Model):
    __tablename__ = 'mdfe_emitente'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(60))
    fantasia = db.Column(db.String(60))
    cnpj = db.Column(db.String(14))
    ie = db.Column(db.Integer)
    logradouro = db.Column(db.String(60))
    numero = db.Column(db.String(60))
    complemento = db.Column(db.String(60))
    bairro = db.Column(db.String(60))
    codigo_municipio = db.Column(db.String(7))
    nome_municipio = db.Column(db.String(60))
    cep = db.Column(db.String(8))
    uf = db.Column(db.String(2))
    telefone = db.Column(db.String(12))
    email = db.Column(db.String(60))
    id_mdfe_cabecalho = db.Column(db.Integer, db.ForeignKey('mdfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_mdfe_cabecalho = data.get('idMdfeCabecalho')
        self.nome = data.get('nome')
        self.fantasia = data.get('fantasia')
        self.cnpj = data.get('cnpj')
        self.ie = data.get('ie')
        self.logradouro = data.get('logradouro')
        self.numero = data.get('numero')
        self.complemento = data.get('complemento')
        self.bairro = data.get('bairro')
        self.codigo_municipio = data.get('codigoMunicipio')
        self.nome_municipio = data.get('nomeMunicipio')
        self.cep = data.get('cep')
        self.uf = data.get('uf')
        self.telefone = data.get('telefone')
        self.email = data.get('email')

    def serialize(self):
        return {
            'id': self.id,
            'idMdfeCabecalho': self.id_mdfe_cabecalho,
            'nome': self.nome,
            'fantasia': self.fantasia,
            'cnpj': self.cnpj,
            'ie': self.ie,
            'logradouro': self.logradouro,
            'numero': self.numero,
            'complemento': self.complemento,
            'bairro': self.bairro,
            'codigoMunicipio': self.codigo_municipio,
            'nomeMunicipio': self.nome_municipio,
            'cep': self.cep,
            'uf': self.uf,
            'telefone': self.telefone,
            'email': self.email,
        }