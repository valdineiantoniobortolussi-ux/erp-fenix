from src import db


class ReuniaoSalaModel(db.Model):
    __tablename__ = 'reuniao_sala'

    id = db.Column(db.Integer, primary_key=True)
    predio = db.Column(db.String(100))
    nome = db.Column(db.String(100))
    andar = db.Column(db.String(10))
    numero = db.Column(db.String(10))


    def mapping(self, data):
        self.id = data.get('id')
        self.predio = data.get('predio')
        self.nome = data.get('nome')
        self.andar = data.get('andar')
        self.numero = data.get('numero')

    def serialize(self):
        return {
            'id': self.id,
            'predio': self.predio,
            'nome': self.nome,
            'andar': self.andar,
            'numero': self.numero,
        }