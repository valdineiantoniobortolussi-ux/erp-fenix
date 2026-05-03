from src import db


class PessoaContatoModel(db.Model):
    __tablename__ = 'pessoa_contato'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(150))
    email = db.Column(db.String(250))
    observacao = db.Column(db.String(250))
    id_pessoa = db.Column(db.Integer, db.ForeignKey('pessoa.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_pessoa = data.get('idPessoa')
        self.nome = data.get('nome')
        self.email = data.get('email')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idPessoa': self.id_pessoa,
            'nome': self.nome,
            'email': self.email,
            'observacao': self.observacao,
        }