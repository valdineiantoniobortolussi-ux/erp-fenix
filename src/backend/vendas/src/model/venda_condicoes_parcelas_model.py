from src import db


class VendaCondicoesParcelasModel(db.Model):
    __tablename__ = 'venda_condicoes_parcelas'

    id = db.Column(db.Integer, primary_key=True)
    parcela = db.Column(db.Integer)
    dias = db.Column(db.Integer)
    taxa = db.Column(db.Float)
    id_venda_condicoes_pagamento = db.Column(db.Integer, db.ForeignKey('venda_condicoes_pagamento.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_venda_condicoes_pagamento = data.get('idVendaCondicoesPagamento')
        self.parcela = data.get('parcela')
        self.dias = data.get('dias')
        self.taxa = data.get('taxa')

    def serialize(self):
        return {
            'id': self.id,
            'idVendaCondicoesPagamento': self.id_venda_condicoes_pagamento,
            'parcela': self.parcela,
            'dias': self.dias,
            'taxa': self.taxa,
        }