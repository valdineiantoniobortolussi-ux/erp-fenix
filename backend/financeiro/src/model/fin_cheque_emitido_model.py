from src import db
from src.model.cheque_model import ChequeModel


class FinChequeEmitidoModel(db.Model):
    __tablename__ = 'fin_cheque_emitido'

    id = db.Column(db.Integer, primary_key=True)
    data_emissao = db.Column(db.DateTime)
    bom_para = db.Column(db.DateTime)
    data_compensacao = db.Column(db.DateTime)
    valor = db.Column(db.Float)
    nominal_a = db.Column(db.String(100))
    id_cheque = db.Column(db.Integer, db.ForeignKey('cheque.id'))

    cheque_model = db.relationship('ChequeModel', foreign_keys=[id_cheque])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cheque = data.get('idCheque')
        self.data_emissao = data.get('dataEmissao')
        self.bom_para = data.get('bomPara')
        self.data_compensacao = data.get('dataCompensacao')
        self.valor = data.get('valor')
        self.nominal_a = data.get('nominalA')

    def serialize(self):
        return {
            'id': self.id,
            'idCheque': self.id_cheque,
            'dataEmissao': self.data_emissao.isoformat(),
            'bomPara': self.bom_para.isoformat(),
            'dataCompensacao': self.data_compensacao.isoformat(),
            'valor': self.valor,
            'nominalA': self.nominal_a,
            'chequeModel': self.cheque_model.serialize() if self.cheque_model else None,
        }