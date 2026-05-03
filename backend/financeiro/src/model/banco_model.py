from src import db


class BancoModel(db.Model):
    __tablename__ = 'banco'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(10))
    nome = db.Column(db.String(100))
    url = db.Column(db.String(250))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')
        self.url = data.get('url')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'nome': self.nome,
            'url': self.url,
        }