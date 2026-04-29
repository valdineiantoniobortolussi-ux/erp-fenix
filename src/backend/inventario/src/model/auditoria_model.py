from src import db


class AuditoriaModel(db.Model):
    __tablename__ = 'auditoria'

    id = db.Column(db.Integer, primary_key=True)
    data_registro = db.Column(db.DateTime)
    hora_registro = db.Column(db.String(8))
    janela_controller = db.Column(db.String(250))
    acao = db.Column(db.String(50))
    conteudo = db.Column(db.Text)
    token_jwt = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.data_registro = data.get('dataRegistro')
        self.hora_registro = data.get('horaRegistro')
        self.janela_controller = data.get('janelaController')
        self.acao = data.get('acao')
        self.conteudo = data.get('conteudo')
        self.token_jwt = data.get('tokenJwt')

    def serialize(self):
        return {
            'id': self.id,
            'dataRegistro': self.data_registro.isoformat(),
            'horaRegistro': self.hora_registro,
            'janelaController': self.janela_controller,
            'acao': self.acao,
            'conteudo': self.conteudo,
            'tokenJwt': self.token_jwt,
        }