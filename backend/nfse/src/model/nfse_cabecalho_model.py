from src import db
from src.model.nfse_detalhe_model import NfseDetalheModel
from src.model.nfse_intermediario_model import NfseIntermediarioModel
from src.model.view_pessoa_cliente_model import ViewPessoaClienteModel
from src.model.os_abertura_model import OsAberturaModel


class NfseCabecalhoModel(db.Model):
    __tablename__ = 'nfse_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    numero = db.Column(db.String(15))
    codigo_verificacao = db.Column(db.String(9))
    data_hora_emissao = db.Column(db.DateTime)
    competencia = db.Column(db.String(6))
    numero_substituida = db.Column(db.String(15))
    natureza_operacao = db.Column(db.String(1))
    regime_especial_tributacao = db.Column(db.String(1))
    optante_simples_nacional = db.Column(db.String(1))
    incentivador_cultural = db.Column(db.String(1))
    numero_rps = db.Column(db.String(15))
    serie_rps = db.Column(db.String(5))
    tipo_rps = db.Column(db.String(1))
    data_emissao_rps = db.Column(db.DateTime)
    outras_informacoes = db.Column(db.Text)
    id_cliente = db.Column(db.Integer, db.ForeignKey('view_pessoa_cliente.id'))
    id_os_abertura = db.Column(db.Integer, db.ForeignKey('os_abertura.id'))

    nfse_detalhe_model_list = db.relationship('NfseDetalheModel', lazy='dynamic')
    nfse_intermediario_model_list = db.relationship('NfseIntermediarioModel', lazy='dynamic')
    view_pessoa_cliente_model = db.relationship('ViewPessoaClienteModel', foreign_keys=[id_cliente])
    os_abertura_model = db.relationship('OsAberturaModel', foreign_keys=[id_os_abertura])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_cliente = data.get('idCliente')
        self.id_os_abertura = data.get('idOsAbertura')
        self.numero = data.get('numero')
        self.codigo_verificacao = data.get('codigoVerificacao')
        self.data_hora_emissao = data.get('dataHoraEmissao')
        self.competencia = data.get('competencia')
        self.numero_substituida = data.get('numeroSubstituida')
        self.natureza_operacao = data.get('naturezaOperacao')
        self.regime_especial_tributacao = data.get('regimeEspecialTributacao')
        self.optante_simples_nacional = data.get('optanteSimplesNacional')
        self.incentivador_cultural = data.get('incentivadorCultural')
        self.numero_rps = data.get('numeroRps')
        self.serie_rps = data.get('serieRps')
        self.tipo_rps = data.get('tipoRps')
        self.data_emissao_rps = data.get('dataEmissaoRps')
        self.outras_informacoes = data.get('outrasInformacoes')

    def serialize(self):
        return {
            'id': self.id,
            'idCliente': self.id_cliente,
            'idOsAbertura': self.id_os_abertura,
            'numero': self.numero,
            'codigoVerificacao': self.codigo_verificacao,
            'dataHoraEmissao': self.data_hora_emissao.isoformat(),
            'competencia': self.competencia,
            'numeroSubstituida': self.numero_substituida,
            'naturezaOperacao': self.natureza_operacao,
            'regimeEspecialTributacao': self.regime_especial_tributacao,
            'optanteSimplesNacional': self.optante_simples_nacional,
            'incentivadorCultural': self.incentivador_cultural,
            'numeroRps': self.numero_rps,
            'serieRps': self.serie_rps,
            'tipoRps': self.tipo_rps,
            'dataEmissaoRps': self.data_emissao_rps.isoformat(),
            'outrasInformacoes': self.outras_informacoes,
            'nfseDetalheModelList': [nfse_detalhe_model.serialize() for nfse_detalhe_model in self.nfse_detalhe_model_list],
            'nfseIntermediarioModelList': [nfse_intermediario_model.serialize() for nfse_intermediario_model in self.nfse_intermediario_model_list],
            'viewPessoaClienteModel': self.view_pessoa_cliente_model.serialize() if self.view_pessoa_cliente_model else None,
            'osAberturaModel': self.os_abertura_model.serialize() if self.os_abertura_model else None,
        }