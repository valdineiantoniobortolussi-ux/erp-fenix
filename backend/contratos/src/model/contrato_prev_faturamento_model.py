from src import db


class ContratoPrevFaturamentoModel(db.Model):
    __tablename__ = 'contrato_prev_faturamento'

    id = db.Column(db.Integer, primary_key=True)
    data_prevista = db.Column(db.DateTime)
    valor = db.Column(db.Float)
    id_contrato = db.Column(db.Integer, db.ForeignKey('contrato.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_contrato = data.get('idContrato')
        self.data_prevista = data.get('dataPrevista')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idContrato': self.id_contrato,
            'dataPrevista': self.data_prevista.isoformat(),
            'valor': self.valor,
        }