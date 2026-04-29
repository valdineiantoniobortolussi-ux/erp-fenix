from src import db


class SefipCategoriaTrabalhoModel(db.Model):
    __tablename__ = 'sefip_categoria_trabalho'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.Integer)
    nome = db.Column(db.Text)


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