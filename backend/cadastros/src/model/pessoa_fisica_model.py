from src import db
from src.model.estado_civil_model import EstadoCivilModel
from src.model.nivel_formacao_model import NivelFormacaoModel


class PessoaFisicaModel(db.Model):
    __tablename__ = 'pessoa_fisica'

    id = db.Column(db.Integer, primary_key=True)
    cpf = db.Column(db.String(11))
    rg = db.Column(db.String(20))
    orgao_rg = db.Column(db.String(20))
    data_emissao_rg = db.Column(db.DateTime)
    data_nascimento = db.Column(db.DateTime)
    sexo = db.Column(db.String(1))
    raca = db.Column(db.String(1))
    nacionalidade = db.Column(db.String(100))
    naturalidade = db.Column(db.String(100))
    nome_pai = db.Column(db.String(200))
    nome_mae = db.Column(db.String(200))
    id_pessoa = db.Column(db.Integer, db.ForeignKey('pessoa.id'), unique=True)
    id_estado_civil = db.Column(db.Integer, db.ForeignKey('estado_civil.id'))
    id_nivel_formacao = db.Column(db.Integer, db.ForeignKey('nivel_formacao.id'))

    estado_civil_model = db.relationship('EstadoCivilModel', foreign_keys=[id_estado_civil])
    nivel_formacao_model = db.relationship('NivelFormacaoModel', foreign_keys=[id_nivel_formacao])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_pessoa = data.get('idPessoa')
        self.id_nivel_formacao = data.get('idNivelFormacao')
        self.id_estado_civil = data.get('idEstadoCivil')
        self.cpf = data.get('cpf')
        self.rg = data.get('rg')
        self.orgao_rg = data.get('orgaoRg')
        self.data_emissao_rg = data.get('dataEmissaoRg')
        self.data_nascimento = data.get('dataNascimento')
        self.sexo = data.get('sexo')
        self.raca = data.get('raca')
        self.nacionalidade = data.get('nacionalidade')
        self.naturalidade = data.get('naturalidade')
        self.nome_pai = data.get('nomePai')
        self.nome_mae = data.get('nomeMae')

    def serialize(self):
        return {
            'id': self.id,
            'idPessoa': self.id_pessoa,
            'idNivelFormacao': self.id_nivel_formacao,
            'idEstadoCivil': self.id_estado_civil,
            'cpf': self.cpf,
            'rg': self.rg,
            'orgaoRg': self.orgao_rg,
            'dataEmissaoRg': self.data_emissao_rg.isoformat(),
            'dataNascimento': self.data_nascimento.isoformat(),
            'sexo': self.sexo,
            'raca': self.raca,
            'nacionalidade': self.nacionalidade,
            'naturalidade': self.naturalidade,
            'nomePai': self.nome_pai,
            'nomeMae': self.nome_mae,
            'estadoCivilModel': self.estado_civil_model.serialize() if self.estado_civil_model else None,
            'nivelFormacaoModel': self.nivel_formacao_model.serialize() if self.nivel_formacao_model else None,
        }