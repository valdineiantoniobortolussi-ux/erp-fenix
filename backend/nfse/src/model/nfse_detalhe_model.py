from src import db
from src.model.nfse_lista_servico_model import NfseListaServicoModel


class NfseDetalheModel(db.Model):
    __tablename__ = 'nfse_detalhe'

    id = db.Column(db.Integer, primary_key=True)
    codigo_cnae = db.Column(db.String(7))
    codigo_tributacao_municipio = db.Column(db.String(20))
    valor_servicos = db.Column(db.Float)
    valor_deducoes = db.Column(db.Float)
    valor_pis = db.Column(db.Float)
    valor_cofins = db.Column(db.Float)
    valor_inss = db.Column(db.Float)
    valor_ir = db.Column(db.Float)
    valor_csll = db.Column(db.Float)
    valor_base_calculo = db.Column(db.Float)
    aliquota = db.Column(db.Float)
    valor_iss = db.Column(db.Float)
    valor_liquido = db.Column(db.Float)
    outras_retencoes = db.Column(db.Float)
    valor_credito = db.Column(db.Float)
    iss_retido = db.Column(db.String(1))
    valor_iss_retido = db.Column(db.Float)
    valor_desconto_condicionado = db.Column(db.Float)
    valor_desconto_incondicionado = db.Column(db.Float)
    municipio_prestacao = db.Column(db.Integer)
    discriminacao = db.Column(db.Text)
    id_nfse_cabecalho = db.Column(db.Integer, db.ForeignKey('nfse_cabecalho.id'))
    id_nfse_lista_servico = db.Column(db.Integer, db.ForeignKey('nfse_lista_servico.id'))

    nfse_lista_servico_model = db.relationship('NfseListaServicoModel', foreign_keys=[id_nfse_lista_servico])

    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfse_cabecalho = data.get('idNfseCabecalho')
        self.id_nfse_lista_servico = data.get('idNfseListaServico')
        self.codigo_cnae = data.get('codigoCnae')
        self.codigo_tributacao_municipio = data.get('codigoTributacaoMunicipio')
        self.valor_servicos = data.get('valorServicos')
        self.valor_deducoes = data.get('valorDeducoes')
        self.valor_pis = data.get('valorPis')
        self.valor_cofins = data.get('valorCofins')
        self.valor_inss = data.get('valorInss')
        self.valor_ir = data.get('valorIr')
        self.valor_csll = data.get('valorCsll')
        self.valor_base_calculo = data.get('valorBaseCalculo')
        self.aliquota = data.get('aliquota')
        self.valor_iss = data.get('valorIss')
        self.valor_liquido = data.get('valorLiquido')
        self.outras_retencoes = data.get('outrasRetencoes')
        self.valor_credito = data.get('valorCredito')
        self.iss_retido = data.get('issRetido')
        self.valor_iss_retido = data.get('valorIssRetido')
        self.valor_desconto_condicionado = data.get('valorDescontoCondicionado')
        self.valor_desconto_incondicionado = data.get('valorDescontoIncondicionado')
        self.municipio_prestacao = data.get('municipioPrestacao')
        self.discriminacao = data.get('discriminacao')

    def serialize(self):
        return {
            'id': self.id,
            'idNfseCabecalho': self.id_nfse_cabecalho,
            'idNfseListaServico': self.id_nfse_lista_servico,
            'codigoCnae': self.codigo_cnae,
            'codigoTributacaoMunicipio': self.codigo_tributacao_municipio,
            'valorServicos': self.valor_servicos,
            'valorDeducoes': self.valor_deducoes,
            'valorPis': self.valor_pis,
            'valorCofins': self.valor_cofins,
            'valorInss': self.valor_inss,
            'valorIr': self.valor_ir,
            'valorCsll': self.valor_csll,
            'valorBaseCalculo': self.valor_base_calculo,
            'aliquota': self.aliquota,
            'valorIss': self.valor_iss,
            'valorLiquido': self.valor_liquido,
            'outrasRetencoes': self.outras_retencoes,
            'valorCredito': self.valor_credito,
            'issRetido': self.iss_retido,
            'valorIssRetido': self.valor_iss_retido,
            'valorDescontoCondicionado': self.valor_desconto_condicionado,
            'valorDescontoIncondicionado': self.valor_desconto_incondicionado,
            'municipioPrestacao': self.municipio_prestacao,
            'discriminacao': self.discriminacao,
            'nfseListaServicoModel': self.nfse_lista_servico_model.serialize() if self.nfse_lista_servico_model else None,
        }