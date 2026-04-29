from src import db


class NfeExportacaoModel(db.Model):
    __tablename__ = 'nfe_exportacao'

    id = db.Column(db.Integer, primary_key=True)
    drawback = db.Column(db.Integer)
    numero_registro = db.Column(db.Integer)
    chave_acesso = db.Column(db.String(44))
    quantidade = db.Column(db.Float)
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.drawback = data.get('drawback')
        self.numero_registro = data.get('numeroRegistro')
        self.chave_acesso = data.get('chaveAcesso')
        self.quantidade = data.get('quantidade')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'drawback': self.drawback,
            'numeroRegistro': self.numero_registro,
            'chaveAcesso': self.chave_acesso,
            'quantidade': self.quantidade,
        }