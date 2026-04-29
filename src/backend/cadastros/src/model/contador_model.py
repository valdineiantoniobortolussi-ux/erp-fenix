from src import db


class ContadorModel(db.Model):
    __tablename__ = 'contador'

    id = db.Column(db.Integer, primary_key=True)
    crc_inscricao = db.Column(db.String(15))
    crc_uf = db.Column(db.String(2))
    id_pessoa = db.Column(db.Integer, db.ForeignKey('pessoa.id'), unique=True)


    def mapping(self, data):
        self.id = data.get('id')
        self.id_pessoa = data.get('idPessoa')
        self.crc_inscricao = data.get('crcInscricao')
        self.crc_uf = data.get('crcUf')

    def serialize(self):
        return {
            'id': self.id,
            'idPessoa': self.id_pessoa,
            'crcInscricao': self.crc_inscricao,
            'crcUf': self.crc_uf,
        }