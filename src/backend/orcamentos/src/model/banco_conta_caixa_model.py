from src import db


class BancoContaCaixaModel(db.Model):
    __tablename__ = 'banco_conta_caixa'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(20))
    digito = db.Column(db.String(1))
    nome = db.Column(db.String(100))
    tipo = db.Column(db.String(1))
    descricao = db.Column(db.String(250))


    def mapping(self, data):
        self.id = data.get('id')
        self.numero = data.get('numero')
        self.digito = data.get('digito')
        self.nome = data.get('nome')
        self.tipo = data.get('tipo')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'numero': self.numero,
            'digito': self.digito,
            'nome': self.nome,
            'tipo': self.tipo,
            'descricao': self.descricao,
        }