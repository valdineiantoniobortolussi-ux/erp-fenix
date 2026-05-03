from src import db


class AgendaCategoriaCompromissoModel(db.Model):
    __tablename__ = 'agenda_categoria_compromisso'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    cor = db.Column(db.String(50))


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.cor = data.get('cor')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'cor': self.cor,
        }