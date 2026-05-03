from src import db


class SeguradoraModel(db.Model):
    __tablename__ = 'seguradora'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(50))
    contato = db.Column(db.String(50))
    telefone = db.Column(db.String(14))


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.contato = data.get('contato')
        self.telefone = data.get('telefone')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'contato': self.contato,
            'telefone': self.telefone,
        }