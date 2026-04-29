from src import db


class FrotaDpvatControleModel(db.Model):
    __tablename__ = 'frota_dpvat_controle'

    id = db.Column(db.Integer, primary_key=True)
    ano = db.Column(db.String(4))
    parcela = db.Column(db.String(2))
    data_vencimento = db.Column(db.DateTime)
    data_pagamento = db.Column(db.DateTime)
    valor = db.Column(db.Float)
    id_frota_veiculo = db.Column(db.Integer, db.ForeignKey('frota_veiculo.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_frota_veiculo = data.get('idFrotaVeiculo')
        self.ano = data.get('ano')
        self.parcela = data.get('parcela')
        self.data_vencimento = data.get('dataVencimento')
        self.data_pagamento = data.get('dataPagamento')
        self.valor = data.get('valor')

    def serialize(self):
        return {
            'id': self.id,
            'idFrotaVeiculo': self.id_frota_veiculo,
            'ano': self.ano,
            'parcela': self.parcela,
            'dataVencimento': self.data_vencimento.isoformat(),
            'dataPagamento': self.data_pagamento.isoformat(),
            'valor': self.valor,
        }