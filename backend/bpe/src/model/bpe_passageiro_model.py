from src import db


class BpePassageiroModel(db.Model):
    __tablename__ = 'bpe_passageiro'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(60))
    cpf = db.Column(db.String(11))
    tipo_documento_identificacao = db.Column(db.String(1))
    numero_documento = db.Column(db.String(20))
    documento_outros_descricao = db.Column(db.String(100))
    data_nascimento = db.Column(db.DateTime)
    telefone = db.Column(db.String(12))
    email = db.Column(db.String(60))
    id_bpe_cabecalho = db.Column(db.Integer, db.ForeignKey('bpe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_bpe_cabecalho = data.get('idBpeCabecalho')
        self.nome = data.get('nome')
        self.cpf = data.get('cpf')
        self.tipo_documento_identificacao = data.get('tipoDocumentoIdentificacao')
        self.numero_documento = data.get('numeroDocumento')
        self.documento_outros_descricao = data.get('documentoOutrosDescricao')
        self.data_nascimento = data.get('dataNascimento')
        self.telefone = data.get('telefone')
        self.email = data.get('email')

    def serialize(self):
        return {
            'id': self.id,
            'idBpeCabecalho': self.id_bpe_cabecalho,
            'nome': self.nome,
            'cpf': self.cpf,
            'tipoDocumentoIdentificacao': self.tipo_documento_identificacao,
            'numeroDocumento': self.numero_documento,
            'documentoOutrosDescricao': self.documento_outros_descricao,
            'dataNascimento': self.data_nascimento.isoformat(),
            'telefone': self.telefone,
            'email': self.email,
        }