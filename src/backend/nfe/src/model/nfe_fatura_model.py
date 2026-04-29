from src import db


class NfeFaturaModel(db.Model):
    __tablename__ = 'nfe_fatura'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(60))
    valor_original = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_liquido = db.Column(db.Float)
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.numero = data.get('numero')
        self.valor_original = data.get('valorOriginal')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_liquido = data.get('valorLiquido')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'numero': self.numero,
            'valorOriginal': self.valor_original,
            'valorDesconto': self.valor_desconto,
            'valorLiquido': self.valor_liquido,
        }