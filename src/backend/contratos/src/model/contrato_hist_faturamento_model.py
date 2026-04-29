from src import db


class ContratoHistFaturamentoModel(db.Model):
    __tablename__ = 'contrato_hist_faturamento'

    id = db.Column(db.Integer, primary_key=True)
    data_fatura = db.Column(db.DateTime)
    valor = db.Column(db.Float)
    id_contrato = db.Column(db.Integer, db.ForeignKey('contrato.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_contrato = data.get('idContrato')
        self.data_fatura = data.get('dataFatura')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idContrato': self.id_contrato,
            'dataFatura': self.data_fatura.isoformat(),
            'valor': self.valor,
        }