from src import db


class CboModel(db.Model):
    __tablename__ = 'cbo'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(10))
    codigo_1994 = db.Column(db.String(10))
    nome = db.Column(db.String(250))
    observacao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.codigo_1994 = data.get('codigo1994')
        self.nome = data.get('nome')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'codigo1994': self.codigo_1994,
            'nome': self.nome,
            'observacao': self.observacao,
        }