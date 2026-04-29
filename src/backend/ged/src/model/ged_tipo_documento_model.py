from src import db


class GedTipoDocumentoModel(db.Model):
    __tablename__ = 'ged_tipo_documento'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    tamanho_maximo = db.Column(db.Float)


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.tamanho_maximo = data.get('tamanhoMaximo')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'tamanhoMaximo': self.tamanho_maximo,
        }