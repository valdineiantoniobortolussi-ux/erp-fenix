from src import db


class NfeNumeroModel(db.Model):
    __tablename__ = 'nfe_numero'

    id = db.Column(db.Integer, primary_key=True)
    serie = db.Column(db.String(3))
    numero = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.serie = data.get('serie')
        self.numero = data.get('numero')

    def serialize(self):
        return {
            'id': self.id,
            'serie': self.serie,
            'numero': self.numero,
        }