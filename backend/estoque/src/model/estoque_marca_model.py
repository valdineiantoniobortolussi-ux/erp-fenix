from src import db


class EstoqueMarcaModel(db.Model):
    __tablename__ = 'estoque_marca'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(4))
    nome = db.Column(db.String(50))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'nome': self.nome,
        }