from src import db


class CteDuplicataModel(db.Model):
    __tablename__ = 'cte_duplicata'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(60))
    data_vencimento = db.Column(db.DateTime)
    valor = db.Column(db.Float)
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.numero = data.get('numero')
        self.data_vencimento = data.get('dataVencimento')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'numero': self.numero,
            'dataVencimento': self.data_vencimento.isoformat(),
            'valor': self.valor,
        }