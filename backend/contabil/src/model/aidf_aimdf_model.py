from src import db


class AidfAimdfModel(db.Model):
    __tablename__ = 'aidf_aimdf'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.Integer)
    data_validade = db.Column(db.DateTime)
    data_autorizacao = db.Column(db.DateTime)
    numero_autorizacao = db.Column(db.String(20))
    formulario_disponivel = db.Column(db.String(1))


    def mapping(self, data):
        self.id = data.get('id')
        self.numero = data.get('numero')
        self.data_validade = data.get('dataValidade')
        self.data_autorizacao = data.get('dataAutorizacao')
        self.numero_autorizacao = data.get('numeroAutorizacao')
        self.formulario_disponivel = data.get('formularioDisponivel')

    def serialize(self):
        return {
            'id': self.id,
            'numero': self.numero,
            'dataValidade': self.data_validade.isoformat(),
            'dataAutorizacao': self.data_autorizacao.isoformat(),
            'numeroAutorizacao': self.numero_autorizacao,
            'formularioDisponivel': self.formulario_disponivel,
        }