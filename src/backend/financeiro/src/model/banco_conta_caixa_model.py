from src import db
from src.model.banco_agencia_model import BancoAgenciaModel


class BancoContaCaixaModel(db.Model):
    __tablename__ = 'banco_conta_caixa'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(20))
    digito = db.Column(db.String(1))
    nome = db.Column(db.String(100))
    tipo = db.Column(db.String(1))
    descricao = db.Column(db.String(250))
    id_banco_agencia = db.Column(db.Integer, db.ForeignKey('banco_agencia.id'))

    banco_agencia_model = db.relationship('BancoAgenciaModel', foreign_keys=[id_banco_agencia])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_banco_agencia = data.get('idBancoAgencia')
        self.numero = data.get('numero')
        self.digito = data.get('digito')
        self.nome = data.get('nome')
        self.tipo = data.get('tipo')
        self.descricao = data.get('descricao')

    def serialize(self):
        return {
            'id': self.id,
            'idBancoAgencia': self.id_banco_agencia,
            'numero': self.numero,
            'digito': self.digito,
            'nome': self.nome,
            'tipo': self.tipo,
            'descricao': self.descricao,
            'bancoAgenciaModel': self.banco_agencia_model.serialize() if self.banco_agencia_model else None,
        }