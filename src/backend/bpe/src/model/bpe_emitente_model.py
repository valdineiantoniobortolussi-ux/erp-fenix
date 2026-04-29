from src import db


class BpeEmitenteModel(db.Model):
    __tablename__ = 'bpe_emitente'

    id = db.Column(db.Integer, primary_key=True)
    cnpj = db.Column(db.String(14))
    ie = db.Column(db.String(14))
    iest = db.Column(db.String(14))
    im = db.Column(db.String(15))
    cnae = db.Column(db.String(7))
    crt = db.Column(db.String(1))
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
    id_bpe_cabecalho = db.Column(db.Integer, db.ForeignKey('bpe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_bpe_cabecalho = data.get('idBpeCabecalho')
        self.cnpj = data.get('cnpj')
        self.ie = data.get('ie')
        self.iest = data.get('iest')
        self.im = data.get('im')
        self.cnae = data.get('cnae')
        self.crt = data.get('crt')
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
            'idBpeCabecalho': self.id_bpe_cabecalho,
            'cnpj': self.cnpj,
            'ie': self.ie,
            'iest': self.iest,
            'im': self.im,
            'cnae': self.cnae,
            'crt': self.crt,
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