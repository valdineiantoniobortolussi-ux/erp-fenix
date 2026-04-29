from src import db


class CodigoGpsModel(db.Model):
    __tablename__ = 'codigo_gps'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.Integer)
    descricao = db.Column(db.String(250))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'descricao': self.descricao,
        }