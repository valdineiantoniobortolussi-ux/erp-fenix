from src import db


class NfeResponsavelTecnicoModel(db.Model):
    __tablename__ = 'nfe_responsavel_tecnico'

    id = db.Column(db.Integer, primary_key=True)
    cnpj = db.Column(db.String(14))
    contato = db.Column(db.String(60))
    email = db.Column(db.String(60))
    telefone = db.Column(db.String(14))
    identificador_csrt = db.Column(db.String(2))
    hash_csrt = db.Column(db.String(28))
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.cnpj = data.get('cnpj')
        self.contato = data.get('contato')
        self.email = data.get('email')
        self.telefone = data.get('telefone')
        self.identificador_csrt = data.get('identificadorCsrt')
        self.hash_csrt = data.get('hashCsrt')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'cnpj': self.cnpj,
            'contato': self.contato,
            'email': self.email,
            'telefone': self.telefone,
            'identificadorCsrt': self.identificador_csrt,
            'hashCsrt': self.hash_csrt,
        }