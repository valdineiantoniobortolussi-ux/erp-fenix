from src import db


class ViewPessoaFornecedorModel(db.Model):
    __tablename__ = 'view_pessoa_fornecedor'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(450))
    tipo = db.Column(db.String(3))
    email = db.Column(db.String(750))
    site = db.Column(db.String(450))
    cpf_cnpj = db.Column(db.String(20))
    rg_ie = db.Column(db.String(20))
    desde = db.Column(db.DateTime)
    data_cadastro = db.Column(db.DateTime)
    observacao = db.Column(db.Text)
    id_pessoa = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.tipo = data.get('tipo')
        self.email = data.get('email')
        self.site = data.get('site')
        self.cpf_cnpj = data.get('cpfCnpj')
        self.rg_ie = data.get('rgIe')
        self.desde = data.get('desde')
        self.data_cadastro = data.get('dataCadastro')
        self.observacao = data.get('observacao')
        self.id_pessoa = data.get('idPessoa')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'tipo': self.tipo,
            'email': self.email,
            'site': self.site,
            'cpfCnpj': self.cpf_cnpj,
            'rgIe': self.rg_ie,
            'desde': self.desde.isoformat(),
            'dataCadastro': self.data_cadastro.isoformat(),
            'observacao': self.observacao,
            'idPessoa': self.id_pessoa,
        }