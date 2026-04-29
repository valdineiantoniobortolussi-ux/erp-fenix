from src import db
from src.model.vendedor_model import VendedorModel
from src.model.pessoa_model import PessoaModel
from src.model.colaborador_situacao_model import ColaboradorSituacaoModel
from src.model.colaborador_tipo_model import ColaboradorTipoModel
from src.model.setor_model import SetorModel
from src.model.cargo_model import CargoModel
from src.model.tipo_admissao_model import TipoAdmissaoModel
from src.model.colaborador_relacionamento_model import ColaboradorRelacionamentoModel
from src.model.sindicato_model import SindicatoModel


class ColaboradorModel(db.Model):
    __tablename__ = 'colaborador'

    id = db.Column(db.Integer, primary_key=True)
    matricula = db.Column(db.String(10))
    data_cadastro = db.Column(db.DateTime)
    data_admissao = db.Column(db.DateTime)
    data_demissao = db.Column(db.DateTime)
    ctps_numero = db.Column(db.String(10))
    ctps_serie = db.Column(db.String(10))
    ctps_data_expedicao = db.Column(db.DateTime)
    ctps_uf = db.Column(db.String(2))
    observacao = db.Column(db.String(250))
    id_pessoa = db.Column(db.Integer, db.ForeignKey('pessoa.id'))
    id_colaborador_situacao = db.Column(db.Integer, db.ForeignKey('colaborador_situacao.id'))
    id_colaborador_tipo = db.Column(db.Integer, db.ForeignKey('colaborador_tipo.id'))
    id_setor = db.Column(db.Integer, db.ForeignKey('setor.id'))
    id_cargo = db.Column(db.Integer, db.ForeignKey('cargo.id'))
    id_tipo_admissao = db.Column(db.Integer, db.ForeignKey('tipo_admissao.id'))
    id_sindicato = db.Column(db.Integer, db.ForeignKey('sindicato.id'))

    vendedor_model = db.relationship('VendedorModel', uselist=False)
    pessoa_model = db.relationship('PessoaModel', foreign_keys=[id_pessoa])
    colaborador_situacao_model = db.relationship('ColaboradorSituacaoModel', foreign_keys=[id_colaborador_situacao])
    colaborador_tipo_model = db.relationship('ColaboradorTipoModel', foreign_keys=[id_colaborador_tipo])
    setor_model = db.relationship('SetorModel', foreign_keys=[id_setor])
    cargo_model = db.relationship('CargoModel', foreign_keys=[id_cargo])
    tipo_admissao_model = db.relationship('TipoAdmissaoModel', foreign_keys=[id_tipo_admissao])
    colaborador_relacionamento_model_list = db.relationship('ColaboradorRelacionamentoModel', lazy='dynamic')
    sindicato_model = db.relationship('SindicatoModel', foreign_keys=[id_sindicato])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_pessoa = data.get('idPessoa')
        self.id_cargo = data.get('idCargo')
        self.id_setor = data.get('idSetor')
        self.id_colaborador_situacao = data.get('idColaboradorSituacao')
        self.id_tipo_admissao = data.get('idTipoAdmissao')
        self.id_colaborador_tipo = data.get('idColaboradorTipo')
        self.id_sindicato = data.get('idSindicato')
        self.matricula = data.get('matricula')
        self.data_cadastro = data.get('dataCadastro')
        self.data_admissao = data.get('dataAdmissao')
        self.data_demissao = data.get('dataDemissao')
        self.ctps_numero = data.get('ctpsNumero')
        self.ctps_serie = data.get('ctpsSerie')
        self.ctps_data_expedicao = data.get('ctpsDataExpedicao')
        self.ctps_uf = data.get('ctpsUf')
        self.observacao = data.get('observacao')

    def serialize(self):
        return {
            'id': self.id,
            'idPessoa': self.id_pessoa,
            'idCargo': self.id_cargo,
            'idSetor': self.id_setor,
            'idColaboradorSituacao': self.id_colaborador_situacao,
            'idTipoAdmissao': self.id_tipo_admissao,
            'idColaboradorTipo': self.id_colaborador_tipo,
            'idSindicato': self.id_sindicato,
            'matricula': self.matricula,
            'dataCadastro': self.data_cadastro.isoformat(),
            'dataAdmissao': self.data_admissao.isoformat(),
            'dataDemissao': self.data_demissao.isoformat(),
            'ctpsNumero': self.ctps_numero,
            'ctpsSerie': self.ctps_serie,
            'ctpsDataExpedicao': self.ctps_data_expedicao.isoformat(),
            'ctpsUf': self.ctps_uf,
            'observacao': self.observacao,
            'vendedorModel': self.vendedor_model.serialize() if self.vendedor_model else None,
            'pessoaModel': self.pessoa_model.serialize() if self.pessoa_model else None,
            'colaboradorSituacaoModel': self.colaborador_situacao_model.serialize() if self.colaborador_situacao_model else None,
            'colaboradorTipoModel': self.colaborador_tipo_model.serialize() if self.colaborador_tipo_model else None,
            'setorModel': self.setor_model.serialize() if self.setor_model else None,
            'cargoModel': self.cargo_model.serialize() if self.cargo_model else None,
            'tipoAdmissaoModel': self.tipo_admissao_model.serialize() if self.tipo_admissao_model else None,
            'colaboradorRelacionamentoModelList': [colaborador_relacionamento_model.serialize() for colaborador_relacionamento_model in self.colaborador_relacionamento_model_list],
            'sindicatoModel': self.sindicato_model.serialize() if self.sindicato_model else None,
        }