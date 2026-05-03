from src import db


class ViewPessoaUsuarioModel(db.Model):
    __tablename__ = 'view_pessoa_usuario'

    id = db.Column(db.Integer, primary_key=True)
    id_pessoa = db.Column(db.Integer)
    pessoa_nome = db.Column(db.String(450))
    tipo = db.Column(db.String(3))
    email = db.Column(db.String(750))
    id_colaborador = db.Column(db.Integer)
    id_usuario = db.Column(db.Integer)
    login = db.Column(db.String(150))
    senha = db.Column(db.String(150))
    data_cadastro = db.Column(db.DateTime)
    administrador = db.Column(db.String(3))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_pessoa = data.get('idPessoa')
        self.pessoa_nome = data.get('pessoaNome')
        self.tipo = data.get('tipo')
        self.email = data.get('email')
        self.id_colaborador = data.get('idColaborador')
        self.id_usuario = data.get('idUsuario')
        self.login = data.get('login')
        self.senha = data.get('senha')
        self.data_cadastro = data.get('dataCadastro')
        self.administrador = data.get('administrador')

    def serialize(self):
        return {
            'id': self.id,
            'idPessoa': self.id_pessoa,
            'pessoaNome': self.pessoa_nome,
            'tipo': self.tipo,
            'email': self.email,
            'idColaborador': self.id_colaborador,
            'idUsuario': self.id_usuario,
            'login': self.login,
            'senha': self.senha,
            'dataCadastro': self.data_cadastro.isoformat(),
            'administrador': self.administrador,
        }