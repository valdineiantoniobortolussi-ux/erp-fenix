from src import db


class TipoAdmissaoModel(db.Model):
    __tablename__ = 'tipo_admissao'

    id = db.Column(db.Integer, primary_key=True)
    codigo = db.Column(db.String(3))
    nome = db.Column(db.String(100))
    descricao = db.Column(db.Text)


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