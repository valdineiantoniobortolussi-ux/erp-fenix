from src import db


class UsuarioTokenModel(db.Model):
    __tablename__ = 'usuario_token'

    id = db.Column(db.Integer, primary_key=True)
    login = db.Column(db.String(50))
    token = db.Column(db.Text)
    data_criacao = db.Column(db.DateTime)
    hora_criacao = db.Column(db.String(8))
    data_expiracao = db.Column(db.DateTime)
    hora_expiracao = db.Column(db.String(8))


    def mapping(self, data):
        self.id = data.get('id')
        self.login = data.get('login')
        self.token = data.get('token')
        self.data_criacao = data.get('dataCriacao')
        self.hora_criacao = data.get('horaCriacao')
        self.data_expiracao = data.get('dataExpiracao')
        self.hora_expiracao = data.get('horaExpiracao')

    def serialize(self):
        return {
            'id': self.id,
            'login': self.login,
            'token': self.token,
            'dataCriacao': self.data_criacao.isoformat(),
            'horaCriacao': self.hora_criacao,
            'dataExpiracao': self.data_expiracao.isoformat(),
            'horaExpiracao': self.hora_expiracao,
        }