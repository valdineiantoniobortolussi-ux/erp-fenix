from src import db


class CepModel(db.Model):
    __tablename__ = 'cep'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(8))
    logradouro = db.Column(db.String(100))
    complemento = db.Column(db.String(100))
    bairro = db.Column(db.String(100))
    municipio = db.Column(db.String(100))
    uf = db.Column(db.String(2))
    codigo_ibge_municipio = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.numero = data.get('numero')
        self.logradouro = data.get('logradouro')
        self.complemento = data.get('complemento')
        self.bairro = data.get('bairro')
        self.municipio = data.get('municipio')
        self.uf = data.get('uf')
        self.codigo_ibge_municipio = data.get('codigoIbgeMunicipio')

    def serialize(self):
        return {
            'id': self.id,
            'numero': self.numero,
            'logradouro': self.logradouro,
            'complemento': self.complemento,
            'bairro': self.bairro,
            'municipio': self.municipio,
            'uf': self.uf,
            'codigoIbgeMunicipio': self.codigo_ibge_municipio,
        }