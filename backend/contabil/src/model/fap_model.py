from src import db


class FapModel(db.Model):
    __tablename__ = 'fap'

    id = db.Column(db.Integer, primary_key=True)
    fap = db.Column(db.Float)
    data_inicial = db.Column(db.DateTime)
    data_final = db.Column(db.DateTime)


    def mapping(self, data):
        self.id = data.get('id')
        self.fap = data.get('fap')
        self.data_inicial = data.get('dataInicial')
        self.data_final = data.get('dataFinal')

    def serialize(self):
        return {
            'id': self.id,
            'fap': self.fap,
            'dataInicial': self.data_inicial.isoformat(),
            'dataFinal': self.data_final.isoformat(),
        }