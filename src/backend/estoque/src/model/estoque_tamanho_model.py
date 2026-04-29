from src import db


class EstoqueTamanhoModel(db.Model):
    __tablename__ = 'estoque_tamanho'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(4))
    nome = db.Column(db.String(50))
    altura = db.Column(db.Float)
    comprimento = db.Column(db.Float)
    largura = db.Column(db.Float)


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')
        self.altura = data.get('altura')
        self.comprimento = data.get('comprimento')
        self.largura = data.get('largura')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'nome': self.nome,
            'altura': self.altura,
            'comprimento': self.comprimento,
            'largura': self.largura,
        }