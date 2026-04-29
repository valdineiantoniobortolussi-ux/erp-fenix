from src import db


class RegistroCartorioModel(db.Model):
    __tablename__ = 'registro_cartorio'

    id = db.Column(db.Integer, primary_key=True)
    nome_cartorio = db.Column(db.String(100))
    data_registro = db.Column(db.DateTime)
    numero = db.Column(db.Integer)
    folha = db.Column(db.Integer)
    livro = db.Column(db.Integer)
    nire = db.Column(db.String(11))


    def mapping(self, data):
        self.id = data.get('id')
        self.nome_cartorio = data.get('nomeCartorio')
        self.data_registro = data.get('dataRegistro')
        self.numero = data.get('numero')
        self.folha = data.get('folha')
        self.livro = data.get('livro')
        self.nire = data.get('nire')

    def serialize(self):
        return {
            'id': self.id,
            'nomeCartorio': self.nome_cartorio,
            'dataRegistro': self.data_registro.isoformat(),
            'numero': self.numero,
            'folha': self.folha,
            'livro': self.livro,
            'nire': self.nire,
        }