from src import db


class SindicatoModel(db.Model):
    __tablename__ = 'sindicato'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    codigo_banco = db.Column(db.Integer)
    codigo_agencia = db.Column(db.Integer)
    conta_banco = db.Column(db.String(20))
    codigo_cedente = db.Column(db.String(30))
    logradouro = db.Column(db.String(100))
    numero = db.Column(db.String(10))
    bairro = db.Column(db.String(100))
    municipio_ibge = db.Column(db.Integer)
    uf = db.Column(db.String(2))
    fone1 = db.Column(db.String(14))
    fone2 = db.Column(db.String(14))
    email = db.Column(db.String(100))
    tipo_sindicato = db.Column(db.String(1))
    data_base = db.Column(db.DateTime)
    piso_salarial = db.Column(db.Float)
    cnpj = db.Column(db.String(14))
    classificacao_contabil_conta = db.Column(db.String(30))


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.codigo_banco = data.get('codigoBanco')
        self.codigo_agencia = data.get('codigoAgencia')
        self.conta_banco = data.get('contaBanco')
        self.codigo_cedente = data.get('codigoCedente')
        self.logradouro = data.get('logradouro')
        self.numero = data.get('numero')
        self.bairro = data.get('bairro')
        self.municipio_ibge = data.get('municipioIbge')
        self.uf = data.get('uf')
        self.fone1 = data.get('fone1')
        self.fone2 = data.get('fone2')
        self.email = data.get('email')
        self.tipo_sindicato = data.get('tipoSindicato')
        self.data_base = data.get('dataBase')
        self.piso_salarial = data.get('pisoSalarial')
        self.cnpj = data.get('cnpj')
        self.classificacao_contabil_conta = data.get('classificacaoContabilConta')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'codigoBanco': self.codigo_banco,
            'codigoAgencia': self.codigo_agencia,
            'contaBanco': self.conta_banco,
            'codigoCedente': self.codigo_cedente,
            'logradouro': self.logradouro,
            'numero': self.numero,
            'bairro': self.bairro,
            'municipioIbge': self.municipio_ibge,
            'uf': self.uf,
            'fone1': self.fone1,
            'fone2': self.fone2,
            'email': self.email,
            'tipoSindicato': self.tipo_sindicato,
            'dataBase': self.data_base.isoformat(),
            'pisoSalarial': self.piso_salarial,
            'cnpj': self.cnpj,
            'classificacaoContabilConta': self.classificacao_contabil_conta,
        }