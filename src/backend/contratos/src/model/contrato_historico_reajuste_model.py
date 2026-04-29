from src import db


class ContratoHistoricoReajusteModel(db.Model):
    __tablename__ = 'contrato_historico_reajuste'

    id = db.Column(db.Integer, primary_key=True)
    indice = db.Column(db.Float)
    valor_anterior = db.Column(db.Float)
    valor_atual = db.Column(db.Float)
    data_reajuste = db.Column(db.DateTime)
    observacao = db.Column(db.Text)
    id_contrato = db.Column(db.Integer, db.ForeignKey('contrato.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_contrato = data.get('idContrato')
        self.indice = data.get('indice')
        self.valor_anterior = data.get('valorAnterior')
        self.valor_atual = data.get('valorAtual')
        self.data_reajuste = data.get('dataReajuste')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idContrato': self.id_contrato,
            'indice': self.indice,
            'valorAnterior': self.valor_anterior,
            'valorAtual': self.valor_atual,
            'dataReajuste': self.data_reajuste.isoformat(),
            'observacao': self.observacao,
        }