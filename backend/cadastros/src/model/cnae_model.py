from src import db


class CnaeModel(db.Model):
    __tablename__ = 'cnae'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(7))
    denominacao = db.Column(db.String(250))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.denominacao = data.get('denominacao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'denominacao': self.denominacao,
        }