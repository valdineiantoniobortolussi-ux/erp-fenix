from src import db


class NfeNumeroInutilizadoModel(db.Model):
    __tablename__ = 'nfe_numero_inutilizado'

    id = db.Column(db.Integer, primary_key=True)
    serie = db.Column(db.String(3))
    numero = db.Column(db.Integer)
    data_inutilizacao = db.Column(db.DateTime)
    observacao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.serie = data.get('serie')
        self.numero = data.get('numero')
        self.data_inutilizacao = data.get('dataInutilizacao')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'serie': self.serie,
            'numero': self.numero,
            'dataInutilizacao': self.data_inutilizacao.isoformat(),
            'observacao': self.observacao,
        }