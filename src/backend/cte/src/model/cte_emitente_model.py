from src import db


class CteEmitenteModel(db.Model):
    __tablename__ = 'cte_emitente'

    id = db.Column(db.Integer, primary_key=True)
    cnpj = db.Column(db.String(14))
    ie = db.Column(db.String(14))
    nome = db.Column(db.String(60))
    fantasia = db.Column(db.String(60))
    logradouro = db.Column(db.String(60))
    numero = db.Column(db.String(60))
    complemento = db.Column(db.String(60))
    bairro = db.Column(db.String(60))
    codigo_municipio = db.Column(db.Integer)
    nome_municipio = db.Column(db.String(60))
    uf = db.Column(db.String(2))
    cep = db.Column(db.String(8))
    telefone = db.Column(db.String(14))
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.cnpj = data.get('cnpj')
        self.ie = data.get('ie')
        self.nome = data.get('nome')
        self.fantasia = data.get('fantasia')
        self.logradouro = data.get('logradouro')
        self.numero = data.get('numero')
        self.complemento = data.get('complemento')
        self.bairro = data.get('bairro')
        self.codigo_municipio = data.get('codigoMunicipio')
        self.nome_municipio = data.get('nomeMunicipio')
        self.uf = data.get('uf')
        self.cep = data.get('cep')
        self.telefone = data.get('telefone')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'cnpj': self.cnpj,
            'ie': self.ie,
            'nome': self.nome,
            'fantasia': self.fantasia,
            'logradouro': self.logradouro,
            'numero': self.numero,
            'complemento': self.complemento,
            'bairro': self.bairro,
            'codigoMunicipio': self.codigo_municipio,
            'nomeMunicipio': self.nome_municipio,
            'uf': self.uf,
            'cep': self.cep,
            'telefone': self.telefone,
        }