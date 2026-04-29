from src import db


class UsuarioModel(db.Model):
    __tablename__ = 'usuario'

    id = db.Column(db.Integer, primary_key=True)
    login = db.Column(db.String(50))
    senha = db.Column(db.String(50))
    administrador = db.Column(db.String(1))
    data_cadastro = db.Column(db.DateTime)
    id_papel = db.Column(db.Integer, db.ForeignKey('papel.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_papel = data.get('idPapel')
        self.id_colaborador = data.get('idColaborador')
        self.login = data.get('login')
        self.senha = data.get('senha')
        self.administrador = data.get('administrador')
        self.data_cadastro = data.get('dataCadastro')

    def serialize(self):
        return {
            'id': self.id,
            'idPapel': self.id_papel,
            'idColaborador': self.id_colaborador,
            'login': self.login,
            'senha': self.senha,
            'administrador': self.administrador,
            'dataCadastro': self.data_cadastro.isoformat(),
        }