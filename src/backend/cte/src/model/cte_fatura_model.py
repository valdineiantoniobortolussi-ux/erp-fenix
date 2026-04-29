from src import db


class CteFaturaModel(db.Model):
    __tablename__ = 'cte_fatura'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(60))
    valor_original = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_liquido = db.Column(db.Float)
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.numero = data.get('numero')
        self.valor_original = data.get('valorOriginal')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_liquido = data.get('valorLiquido')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'numero': self.numero,
            'valorOriginal': self.valor_original,
            'valorDesconto': self.valor_desconto,
            'valorLiquido': self.valor_liquido,
        }