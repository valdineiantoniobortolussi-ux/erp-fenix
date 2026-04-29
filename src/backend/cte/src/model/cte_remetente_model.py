from src import db


class CteRemetenteModel(db.Model):
    __tablename__ = 'cte_remetente'

    id = db.Column(db.Integer, primary_key=True)
    cnpj = db.Column(db.String(14))
    cpf = db.Column(db.String(11))
    ie = db.Column(db.String(20))
    nome = db.Column(db.String(60))
    fantasia = db.Column(db.String(60))
    telefone = db.Column(db.String(14))
    logradouro = db.Column(db.String(250))
    numero = db.Column(db.String(60))
    complemento = db.Column(db.String(60))
    bairro = db.Column(db.String(60))
    codigo_municipio = db.Column(db.Integer)
    nome_municipio = db.Column(db.String(60))
    uf = db.Column(db.String(2))
    cep = db.Column(db.String(8))
    codigo_pais = db.Column(db.Integer)
    nome_pais = db.Column(db.String(60))
    email = db.Column(db.String(60))
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.cnpj = data.get('cnpj')
        self.cpf = data.get('cpf')
        self.ie = data.get('ie')
        self.nome = data.get('nome')
        self.fantasia = data.get('fantasia')
        self.telefone = data.get('telefone')
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
        self.email = data.get('email')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'cnpj': self.cnpj,
            'cpf': self.cpf,
            'ie': self.ie,
            'nome': self.nome,
            'fantasia': self.fantasia,
            'telefone': self.telefone,
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
            'email': self.email,
        }