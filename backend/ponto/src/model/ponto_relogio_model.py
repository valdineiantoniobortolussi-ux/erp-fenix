from src import db


class PontoRelogioModel(db.Model):
    __tablename__ = 'ponto_relogio'

    id = db.Column(db.Integer, primary_key=True)
    localizacao = db.Column(db.String(50))
    marca = db.Column(db.String(30))
    fabricante = db.Column(db.String(30))
    numero_serie = db.Column(db.String(50))
    utilizacao = db.Column(db.String(1))


    def mapping(self, data):
        self.id = data.get('id')
        self.localizacao = data.get('localizacao')
        self.marca = data.get('marca')
        self.fabricante = data.get('fabricante')
        self.numero_serie = data.get('numeroSerie')
        self.utilizacao = data.get('utilizacao')

    def serialize(self):
        return {
            'id': self.id,
            'localizacao': self.localizacao,
            'marca': self.marca,
            'fabricante': self.fabricante,
            'numeroSerie': self.numero_serie,
            'utilizacao': self.utilizacao,
        }