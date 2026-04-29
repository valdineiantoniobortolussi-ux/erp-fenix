from src import db


class EtiquetaFormatoPapelModel(db.Model):
    __tablename__ = 'etiqueta_formato_papel'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(50))
    altura = db.Column(db.Integer)
    largura = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.altura = data.get('altura')
        self.largura = data.get('largura')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'altura': self.altura,
            'largura': self.largura,
        }