from src import db


class ColaboradorSituacaoModel(db.Model):
    __tablename__ = 'colaborador_situacao'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(3))
    nome = db.Column(db.String(100))
    descricao = db.Column(db.String(250))


    def mapping(self, data):
        self.id = data.get('id')
        self.codigo = data.get('codigo')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'codigo': self.codigo,
            'nome': self.nome,
            'descricao': self.descricao,
        }