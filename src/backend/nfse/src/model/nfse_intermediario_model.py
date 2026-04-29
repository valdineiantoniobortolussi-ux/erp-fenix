from src import db


class NfseIntermediarioModel(db.Model):
    __tablename__ = 'nfse_intermediario'

    id = db.Column(db.Integer, primary_key=True)
    cnpj = db.Column(db.String(14))
    inscricao_municipal = db.Column(db.String(15))
    razao = db.Column(db.String(150))
    id_nfse_cabecalho = db.Column(db.Integer, db.ForeignKey('nfse_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfse_cabecalho = data.get('idNfseCabecalho')
        self.cnpj = data.get('cnpj')
        self.inscricao_municipal = data.get('inscricaoMunicipal')
        self.razao = data.get('razao')

    def serialize(self):
        return {
            'id': self.id,
            'idNfseCabecalho': self.id_nfse_cabecalho,
            'cnpj': self.cnpj,
            'inscricaoMunicipal': self.inscricao_municipal,
            'razao': self.razao,
        }