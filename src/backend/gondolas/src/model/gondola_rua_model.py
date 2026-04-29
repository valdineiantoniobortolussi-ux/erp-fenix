from src import db


class GondolaRuaModel(db.Model):
    __tablename__ = 'gondola_rua'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(10))
    quantidade_estante = db.Column(db.Integer)
    nome = db.Column(db.String(100))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.quantidade_estante = data.get('quantidadeEstante')
        self.nome = data.get('nome')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'quantidadeEstante': self.quantidade_estante,
            'nome': self.nome,
        }