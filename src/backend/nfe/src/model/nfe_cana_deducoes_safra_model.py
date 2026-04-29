from src import db
from src.model.nfe_cana_model import NfeCanaModel


class NfeCanaDeducoesSafraModel(db.Model):
    __tablename__ = 'nfe_cana_deducoes_safra'

    id = db.Column(db.Integer, primary_key=True)
    decricao = db.Column(db.String(60))
    valor_deducao = db.Column(db.Float)
    valor_fornecimento = db.Column(db.Float)
    valor_total_deducao = db.Column(db.Float)
    valor_liquido_fornecimento = db.Column(db.Float)
    id_nfe_cana = db.Column(db.Integer, db.ForeignKey('nfe_cana.id'))

    nfe_cana_model = db.relationship('NfeCanaModel', foreign_keys=[id_nfe_cana])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cana = data.get('idNfeCana')
        self.decricao = data.get('decricao')
        self.valor_deducao = data.get('valorDeducao')
        self.valor_fornecimento = data.get('valorFornecimento')
        self.valor_total_deducao = data.get('valorTotalDeducao')
        self.valor_liquido_fornecimento = data.get('valorLiquidoFornecimento')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCana': self.id_nfe_cana,
            'decricao': self.decricao,
            'valorDeducao': self.valor_deducao,
            'valorFornecimento': self.valor_fornecimento,
            'valorTotalDeducao': self.valor_total_deducao,
            'valorLiquidoFornecimento': self.valor_liquido_fornecimento,
            'nfeCanaModel': self.nfe_cana_model.serialize() if self.nfe_cana_model else None,
        }