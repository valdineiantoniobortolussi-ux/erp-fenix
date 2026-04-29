from src import db
from src.model.banco_model import BancoModel


class BancoAgenciaModel(db.Model):
    __tablename__ = 'banco_agencia'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(20))
    digito = db.Column(db.String(1))
    nome = db.Column(db.String(100))
    telefone = db.Column(db.String(15))
    contato = db.Column(db.String(100))
    gerente = db.Column(db.String(100))
    observacao = db.Column(db.String(250))
    id_banco = db.Column(db.Integer, db.ForeignKey('banco.id'))

    banco_model = db.relationship('BancoModel', foreign_keys=[id_banco])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_banco = data.get('idBanco')
        self.numero = data.get('numero')
        self.digito = data.get('digito')
        self.nome = data.get('nome')
        self.telefone = data.get('telefone')
        self.contato = data.get('contato')
        self.gerente = data.get('gerente')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idBanco': self.id_banco,
            'numero': self.numero,
            'digito': self.digito,
            'nome': self.nome,
            'telefone': self.telefone,
            'contato': self.contato,
            'gerente': self.gerente,
            'observacao': self.observacao,
            'bancoModel': self.banco_model.serialize() if self.banco_model else None,
        }