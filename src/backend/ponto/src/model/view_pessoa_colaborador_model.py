from src import db


class ViewPessoaColaboradorModel(db.Model):
    __tablename__ = 'view_pessoa_colaborador'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(450))
    tipo = db.Column(db.String(3))
    email = db.Column(db.String(750))
    site = db.Column(db.String(450))
    cpf_cnpj = db.Column(db.String(20))
    rg_ie = db.Column(db.String(20))
    matricula = db.Column(db.String(50))
    data_cadastro = db.Column(db.DateTime)
    data_admissao = db.Column(db.DateTime)
    data_demissao = db.Column(db.DateTime)
    ctps_numero = db.Column(db.String(20))
    ctps_serie = db.Column(db.String(10))
    ctps_data_expedicao = db.Column(db.DateTime)
    ctps_uf = db.Column(db.String(2))
    observacao = db.Column(db.Text)
    logradouro = db.Column(db.String(450))
    numero = db.Column(db.String(20))
    complemento = db.Column(db.String(450))
    bairro = db.Column(db.String(150))
    cidade = db.Column(db.String(150))
    cep = db.Column(db.String(10))
    municipio_ibge = db.Column(db.String(10))
    uf = db.Column(db.String(2))
    id_pessoa = db.Column(db.Integer)
    id_cargo = db.Column(db.Integer)
    id_setor = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.nome = data.get('nome')
        self.tipo = data.get('tipo')
        self.email = data.get('email')
        self.site = data.get('site')
        self.cpf_cnpj = data.get('cpfCnpj')
        self.rg_ie = data.get('rgIe')
        self.matricula = data.get('matricula')
        self.data_cadastro = data.get('dataCadastro')
        self.data_admissao = data.get('dataAdmissao')
        self.data_demissao = data.get('dataDemissao')
        self.ctps_numero = data.get('ctpsNumero')
        self.ctps_serie = data.get('ctpsSerie')
        self.ctps_data_expedicao = data.get('ctpsDataExpedicao')
        self.ctps_uf = data.get('ctpsUf')
        self.observacao = data.get('observacao')
        self.logradouro = data.get('logradouro')
        self.numero = data.get('numero')
        self.complemento = data.get('complemento')
        self.bairro = data.get('bairro')
        self.cidade = data.get('cidade')
        self.cep = data.get('cep')
        self.municipio_ibge = data.get('municipioIbge')
        self.uf = data.get('uf')
        self.id_pessoa = data.get('idPessoa')
        self.id_cargo = data.get('idCargo')
        self.id_setor = data.get('idSetor')

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'tipo': self.tipo,
            'email': self.email,
            'site': self.site,
            'cpfCnpj': self.cpf_cnpj,
            'rgIe': self.rg_ie,
            'matricula': self.matricula,
            'dataCadastro': self.data_cadastro.isoformat(),
            'dataAdmissao': self.data_admissao.isoformat(),
            'dataDemissao': self.data_demissao.isoformat(),
            'ctpsNumero': self.ctps_numero,
            'ctpsSerie': self.ctps_serie,
            'ctpsDataExpedicao': self.ctps_data_expedicao.isoformat(),
            'ctpsUf': self.ctps_uf,
            'observacao': self.observacao,
            'logradouro': self.logradouro,
            'numero': self.numero,
            'complemento': self.complemento,
            'bairro': self.bairro,
            'cidade': self.cidade,
            'cep': self.cep,
            'municipioIbge': self.municipio_ibge,
            'uf': self.uf,
            'idPessoa': self.id_pessoa,
            'idCargo': self.id_cargo,
            'idSetor': self.id_setor,
        }