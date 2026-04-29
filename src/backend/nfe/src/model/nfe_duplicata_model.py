from src import db
from src.model.nfe_fatura_model import NfeFaturaModel


class NfeDuplicataModel(db.Model):
    __tablename__ = 'nfe_duplicata'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(60))
    data_vencimento = db.Column(db.DateTime)
    valor = db.Column(db.Float)
    id_nfe_fatura = db.Column(db.Integer, db.ForeignKey('nfe_fatura.id'))

    nfe_fatura_model = db.relationship('NfeFaturaModel', foreign_keys=[id_nfe_fatura])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_fatura = data.get('idNfeFatura')
        self.numero = data.get('numero')
        self.data_vencimento = data.get('dataVencimento')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeFatura': self.id_nfe_fatura,
            'numero': self.numero,
            'dataVencimento': self.data_vencimento.isoformat(),
            'valor': self.valor,
            'nfeFaturaModel': self.nfe_fatura_model.serialize() if self.nfe_fatura_model else None,
        }