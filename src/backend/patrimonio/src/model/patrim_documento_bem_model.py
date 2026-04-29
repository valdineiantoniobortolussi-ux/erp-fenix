from src import db


class PatrimDocumentoBemModel(db.Model):
    __tablename__ = 'patrim_documento_bem'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(50))
    descricao = db.Column(db.Text)
    imagem = db.Column(db.Text)
    id_patrim_bem = db.Column(db.Integer, db.ForeignKey('patrim_bem.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_patrim_bem = data.get('idPatrimBem')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.imagem = data.get('imagem')

    def serialize(self):
        return {
            'id': self.id,
            'idPatrimBem': self.id_patrim_bem,
            'nome': self.nome,
            'descricao': self.descricao,
            'imagem': self.imagem,
        }