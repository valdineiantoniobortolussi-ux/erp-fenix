from src import db


class ContabilLancamentoPadraoModel(db.Model):
    __tablename__ = 'contabil_lancamento_padrao'

    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(100))
    historico = db.Column(db.String(250))
    id_conta_debito = db.Column(db.Integer)
    id_conta_credito = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.descricao = data.get('descricao')
        self.historico = data.get('historico')
        self.id_conta_debito = data.get('idContaDebito')
        self.id_conta_credito = data.get('idContaCredito')

    def serialize(self):
        return {
            'id': self.id,
            'descricao': self.descricao,
            'historico': self.historico,
            'idContaDebito': self.id_conta_debito,
            'idContaCredito': self.id_conta_credito,
        }