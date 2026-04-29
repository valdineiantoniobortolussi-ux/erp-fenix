from src import db
from src.model.cte_ferroviario_model import CteFerroviarioModel


class CteFerroviarioFerroviaModel(db.Model):
    __tablename__ = 'cte_ferroviario_ferrovia'

    id = db.Column(db.Integer, primary_key=True)
    cnpj = db.Column(db.String(14))
    codigo_interno = db.Column(db.String(10))
    ie = db.Column(db.String(20))
    nome = db.Column(db.String(60))
    logradouro = db.Column(db.String(250))
    numero = db.Column(db.String(60))
    complemento = db.Column(db.String(60))
    bairro = db.Column(db.String(60))
    codigo_municipio = db.Column(db.Integer)
    nome_municipio = db.Column(db.String(60))
    uf = db.Column(db.String(2))
    cep = db.Column(db.String(8))
    id_cte_ferroviario = db.Column(db.Integer, db.ForeignKey('cte_ferroviario.id'))

    cte_ferroviario_model = db.relationship('CteFerroviarioModel', foreign_keys=[id_cte_ferroviario])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_ferroviario = data.get('idCteFerroviario')
        self.cnpj = data.get('cnpj')
        self.codigo_interno = data.get('codigoInterno')
        self.ie = data.get('ie')
        self.nome = data.get('nome')
        self.logradouro = data.get('logradouro')
        self.numero = data.get('numero')
        self.complemento = data.get('complemento')
        self.bairro = data.get('bairro')
        self.codigo_municipio = data.get('codigoMunicipio')
        self.nome_municipio = data.get('nomeMunicipio')
        self.uf = data.get('uf')
        self.cep = data.get('cep')

    def serialize(self):
        return {
            'id': self.id,
            'idCteFerroviario': self.id_cte_ferroviario,
            'cnpj': self.cnpj,
            'codigoInterno': self.codigo_interno,
            'ie': self.ie,
            'nome': self.nome,
            'logradouro': self.logradouro,
            'numero': self.numero,
            'complemento': self.complemento,
            'bairro': self.bairro,
            'codigoMunicipio': self.codigo_municipio,
            'nomeMunicipio': self.nome_municipio,
            'uf': self.uf,
            'cep': self.cep,
            'cteFerroviarioModel': self.cte_ferroviario_model.serialize() if self.cte_ferroviario_model else None,
        }