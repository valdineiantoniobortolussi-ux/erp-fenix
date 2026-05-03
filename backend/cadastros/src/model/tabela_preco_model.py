from src import db


class TabelaPrecoModel(db.Model):
    __tablename__ = 'tabela_preco'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    principal = db.Column(db.String(1))
    coeficiente = db.Column(db.Float)


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.principal = data.get('principal')
        self.coeficiente = data.get('coeficiente')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'principal': self.principal,
            'coeficiente': self.coeficiente,
        }