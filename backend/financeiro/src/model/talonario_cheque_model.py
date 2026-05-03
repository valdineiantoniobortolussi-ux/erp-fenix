from src import db
from src.model.cheque_model import ChequeModel
from src.model.banco_conta_caixa_model import BancoContaCaixaModel


class TalonarioChequeModel(db.Model):
    __tablename__ = 'talonario_cheque'

    id = db.Column(db.Integer, primary_key=True)
    talao = db.Column(db.String(10))
    numero = db.Column(db.Integer)
    status_talao = db.Column(db.String(1))
    id_banco_conta_caixa = db.Column(db.Integer, db.ForeignKey('banco_conta_caixa.id'))

    cheque_model_list = db.relationship('ChequeModel', lazy='dynamic')
    banco_conta_caixa_model = db.relationship('BancoContaCaixaModel', foreign_keys=[id_banco_conta_caixa])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_banco_conta_caixa = data.get('idBancoContaCaixa')
        self.talao = data.get('talao')
        self.numero = data.get('numero')
        self.status_talao = data.get('statusTalao')

    def serialize(self):
        return {
            'id': self.id,
            'idBancoContaCaixa': self.id_banco_conta_caixa,
            'talao': self.talao,
            'numero': self.numero,
            'statusTalao': self.status_talao,
            'chequeModelList': [cheque_model.serialize() for cheque_model in self.cheque_model_list],
            'bancoContaCaixaModel': self.banco_conta_caixa_model.serialize() if self.banco_conta_caixa_model else None,
        }