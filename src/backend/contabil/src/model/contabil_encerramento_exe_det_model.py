from src import db
from src.model.contabil_conta_model import ContabilContaModel


class ContabilEncerramentoExeDetModel(db.Model):
    __tablename__ = 'contabil_encerramento_exe_det'

    id = db.Column(db.Integer, primary_key=True)
    saldo_anterior = db.Column(db.Float)
    valor_debito = db.Column(db.Float)
    valor_credito = db.Column(db.Float)
    saldo = db.Column(db.Float)
    id_contabil_encerramento_exe = db.Column(db.Integer, db.ForeignKey('contabil_encerramento_exe_cab.id'))
    id_contabil_conta = db.Column(db.Integer, db.ForeignKey('contabil_conta.id'))

    contabil_conta_model = db.relationship('ContabilContaModel', foreign_keys=[id_contabil_conta])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_contabil_encerramento_exe = data.get('idContabilEncerramentoExe')
        self.id_contabil_conta = data.get('idContabilConta')
        self.saldo_anterior = data.get('saldoAnterior')
        self.valor_debito = data.get('valorDebito')
        self.valor_credito = data.get('valorCredito')
        self.saldo = data.get('saldo')

    def serialize(self):
        return {
            'id': self.id,
            'idContabilEncerramentoExe': self.id_contabil_encerramento_exe,
            'idContabilConta': self.id_contabil_conta,
            'saldoAnterior': self.saldo_anterior,
            'valorDebito': self.valor_debito,
            'valorCredito': self.valor_credito,
            'saldo': self.saldo,
            'contabilContaModel': self.contabil_conta_model.serialize() if self.contabil_conta_model else None,
        }