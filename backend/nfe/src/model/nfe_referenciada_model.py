from src import db


class NfeReferenciadaModel(db.Model):
    __tablename__ = 'nfe_referenciada'

    id = db.Column(db.Integer, primary_key=True)
    chave_acesso = db.Column(db.String(44))
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.chave_acesso = data.get('chaveAcesso')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'chaveAcesso': self.chave_acesso,
        }