from src import db
from src.model.tipo_relacionamento_model import TipoRelacionamentoModel


class ColaboradorRelacionamentoModel(db.Model):
    __tablename__ = 'colaborador_relacionamento'

    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100))
    data_nascimento = db.Column(db.DateTime)
    cpf = db.Column(db.String(11))
    registro_matricula = db.Column(db.String(50))
    registro_cartorio = db.Column(db.String(50))
    registro_cartorio_numero = db.Column(db.String(50))
    registro_numero_livro = db.Column(db.String(10))
    registro_numero_folha = db.Column(db.String(10))
    data_entrega_documento = db.Column(db.DateTime)
    salario_familia = db.Column(db.String(1))
    salario_familia_idade_limite = db.Column(db.Integer)
    salario_familia_data_fim = db.Column(db.DateTime)
    imposto_renda_idade_limite = db.Column(db.Integer)
    imposto_renda_data_fim = db.Column(db.Integer)
    id_colaborador = db.Column(db.Integer, db.ForeignKey('colaborador.id'))
    id_tipo_relacionamento = db.Column(db.Integer, db.ForeignKey('tipo_relacionamento.id'))

    tipo_relacionamento_model = db.relationship('TipoRelacionamentoModel', foreign_keys=[id_tipo_relacionamento])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_colaborador = data.get('idColaborador')
        self.id_tipo_relacionamento = data.get('idTipoRelacionamento')
        self.nome = data.get('nome')
        self.data_nascimento = data.get('dataNascimento')
        self.cpf = data.get('cpf')
        self.registro_matricula = data.get('registroMatricula')
        self.registro_cartorio = data.get('registroCartorio')
        self.registro_cartorio_numero = data.get('registroCartorioNumero')
        self.registro_numero_livro = data.get('registroNumeroLivro')
        self.registro_numero_folha = data.get('registroNumeroFolha')
        self.data_entrega_documento = data.get('dataEntregaDocumento')
        self.salario_familia = data.get('salarioFamilia')
        self.salario_familia_idade_limite = data.get('salarioFamiliaIdadeLimite')
        self.salario_familia_data_fim = data.get('salarioFamiliaDataFim')
        self.imposto_renda_idade_limite = data.get('impostoRendaIdadeLimite')
        self.imposto_renda_data_fim = data.get('impostoRendaDataFim')

    def serialize(self):
        return {
            'id': self.id,
            'idColaborador': self.id_colaborador,
            'idTipoRelacionamento': self.id_tipo_relacionamento,
            'nome': self.nome,
            'dataNascimento': self.data_nascimento.isoformat(),
            'cpf': self.cpf,
            'registroMatricula': self.registro_matricula,
            'registroCartorio': self.registro_cartorio,
            'registroCartorioNumero': self.registro_cartorio_numero,
            'registroNumeroLivro': self.registro_numero_livro,
            'registroNumeroFolha': self.registro_numero_folha,
            'dataEntregaDocumento': self.data_entrega_documento.isoformat(),
            'salarioFamilia': self.salario_familia,
            'salarioFamiliaIdadeLimite': self.salario_familia_idade_limite,
            'salarioFamiliaDataFim': self.salario_familia_data_fim.isoformat(),
            'impostoRendaIdadeLimite': self.imposto_renda_idade_limite,
            'impostoRendaDataFim': self.imposto_renda_data_fim,
            'tipoRelacionamentoModel': self.tipo_relacionamento_model.serialize() if self.tipo_relacionamento_model else None,
        }