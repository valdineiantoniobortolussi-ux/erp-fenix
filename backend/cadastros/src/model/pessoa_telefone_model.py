from src import db


class PessoaTelefoneModel(db.Model):
    __tablename__ = 'pessoa_telefone'

    id = db.Column(db.Integer, primary_key=True)
    tipo = db.Column(db.String(1))
    numero = db.Column(db.String(15))
    id_pessoa = db.Column(db.Integer, db.ForeignKey('pessoa.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_pessoa = data.get('idPessoa')
        self.tipo = data.get('tipo')
        self.numero = data.get('numero')

    def serialize(self):
        return {
            'id': self.id,
            'idPessoa': self.id_pessoa,
            'tipo': self.tipo,
            'numero': self.numero,
        }