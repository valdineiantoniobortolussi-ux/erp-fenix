from src import db


class SalarioMinimoModel(db.Model):
    __tablename__ = 'salario_minimo'

    id = db.Column(db.Integer, primary_key=True)
    vigencia = db.Column(db.DateTime)
    valor_mensal = db.Column(db.Float)
    valor_diario = db.Column(db.Float)
    valor_hora = db.Column(db.Float)
    norma_legal = db.Column(db.String(100))
    dou = db.Column(db.DateTime)


    def mapping(self, data):
        self.id = data.get('id')
        self.vigencia = data.get('vigencia')
        self.valor_mensal = data.get('valorMensal')
        self.valor_diario = data.get('valorDiario')
        self.valor_hora = data.get('valorHora')
        self.norma_legal = data.get('normaLegal')
        self.dou = data.get('dou')

    def serialize(self):
        return {
            'id': self.id,
            'vigencia': self.vigencia.isoformat(),
            'valorMensal': self.valor_mensal,
            'valorDiario': self.valor_diario,
            'valorHora': self.valor_hora,
            'normaLegal': self.norma_legal,
            'dou': self.dou.isoformat(),
        }