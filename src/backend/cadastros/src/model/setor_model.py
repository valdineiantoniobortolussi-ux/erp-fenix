from src import db


class SetorModel(db.Model):
    __tablename__ = 'setor'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    descricao = db.Column(db.String(250))


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'descricao': self.descricao,
        }