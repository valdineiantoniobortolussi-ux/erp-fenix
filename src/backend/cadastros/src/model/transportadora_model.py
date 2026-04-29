from src import db


class TransportadoraModel(db.Model):
    __tablename__ = 'transportadora'

    id = db.Column(db.Integer, primary_key=True)
    data_cadastro = db.Column(db.DateTime)
    observacao = db.Column(db.String(250))
    id_pessoa = db.Column(db.Integer, db.ForeignKey('pessoa.id'), unique=True)


    def mapping(self, data):
        self.id = data.get('id')
        self.id_pessoa = data.get('idPessoa')
        self.data_cadastro = data.get('dataCadastro')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idPessoa': self.id_pessoa,
            'dataCadastro': self.data_cadastro.isoformat(),
            'observacao': self.observacao,
        }