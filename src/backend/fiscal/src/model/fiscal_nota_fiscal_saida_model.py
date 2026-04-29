from src import db
from src.model.nfe_cabecalho_model import NfeCabecalhoModel


class FiscalNotaFiscalSaidaModel(db.Model):
    __tablename__ = 'fiscal_nota_fiscal_saida'

    id = db.Column(db.Integer, primary_key=True)
    competencia = db.Column(db.String(7))
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))

    nfe_cabecalho_model = db.relationship('NfeCabecalhoModel', foreign_keys=[id_nfe_cabecalho])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.competencia = data.get('competencia')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'competencia': self.competencia,
            'nfeCabecalhoModel': self.nfe_cabecalho_model.serialize() if self.nfe_cabecalho_model else None,
        }