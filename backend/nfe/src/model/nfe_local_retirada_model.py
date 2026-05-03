from src import db


class NfeLocalRetiradaModel(db.Model):
    __tablename__ = 'nfe_local_retirada'

    id = db.Column(db.Integer, primary_key=True)
    cnpj = db.Column(db.String(14))
    cpf = db.Column(db.String(11))
    nome_expedidor = db.Column(db.String(60))
    logradouro = db.Column(db.String(60))
    numero = db.Column(db.String(60))
    complemento = db.Column(db.String(60))
    bairro = db.Column(db.String(60))
    codigo_municipio = db.Column(db.Integer)
    nome_municipio = db.Column(db.String(60))
    uf = db.Column(db.String(2))
    cep = db.Column(db.String(8))
    codigo_pais = db.Column(db.Integer)
    nome_pais = db.Column(db.String(60))
    telefone = db.Column(db.String(14))
    email = db.Column(db.String(60))
    inscricao_estadual = db.Column(db.String(14))
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.cnpj = data.get('cnpj')
        self.cpf = data.get('cpf')
        self.nome_expedidor = data.get('nomeExpedidor')
        self.logradouro = data.get('logradouro')
        self.numero = data.get('numero')
        self.complemento = data.get('complemento')
        self.bairro = data.get('bairro')
        self.codigo_municipio = data.get('codigoMunicipio')
        self.nome_municipio = data.get('nomeMunicipio')
        self.uf = data.get('uf')
        self.cep = data.get('cep')
        self.codigo_pais = data.get('codigoPais')
        self.nome_pais = data.get('nomePais')
        self.telefone = data.get('telefone')
        self.email = data.get('email')
        self.inscricao_estadual = data.get('inscricaoEstadual')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'cnpj': self.cnpj,
            'cpf': self.cpf,
            'nomeExpedidor': self.nome_expedidor,
            'logradouro': self.logradouro,
            'numero': self.numero,
            'complemento': self.complemento,
            'bairro': self.bairro,
            'codigoMunicipio': self.codigo_municipio,
            'nomeMunicipio': self.nome_municipio,
            'uf': self.uf,
            'cep': self.cep,
            'codigoPais': self.codigo_pais,
            'nomePais': self.nome_pais,
            'telefone': self.telefone,
            'email': self.email,
            'inscricaoEstadual': self.inscricao_estadual,
        }