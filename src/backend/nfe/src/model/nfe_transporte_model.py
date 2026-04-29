from src import db


class NfeTransporteModel(db.Model):
    __tablename__ = 'nfe_transporte'

    id = db.Column(db.Integer, primary_key=True)
    id_transportadora = db.Column(db.Integer)
    modalidade_frete = db.Column(db.String(1))
    cnpj = db.Column(db.String(14))
    cpf = db.Column(db.String(11))
    nome = db.Column(db.String(60))
    inscricao_estadual = db.Column(db.String(14))
    endereco = db.Column(db.String(60))
    nome_municipio = db.Column(db.String(60))
    uf = db.Column(db.String(2))
    valor_servico = db.Column(db.Float)
    valor_bc_retencao_icms = db.Column(db.Float)
    aliquota_retencao_icms = db.Column(db.Float)
    valor_icms_retido = db.Column(db.Float)
    cfop = db.Column(db.Integer)
    municipio = db.Column(db.Integer)
    placa_veiculo = db.Column(db.String(7))
    uf_veiculo = db.Column(db.String(2))
    rntc_veiculo = db.Column(db.String(20))
    id_nfe_cabecalho = db.Column(db.Integer, db.ForeignKey('nfe_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_cabecalho = data.get('idNfeCabecalho')
        self.id_transportadora = data.get('idTransportadora')
        self.modalidade_frete = data.get('modalidadeFrete')
        self.cnpj = data.get('cnpj')
        self.cpf = data.get('cpf')
        self.nome = data.get('nome')
        self.inscricao_estadual = data.get('inscricaoEstadual')
        self.endereco = data.get('endereco')
        self.nome_municipio = data.get('nomeMunicipio')
        self.uf = data.get('uf')
        self.valor_servico = data.get('valorServico')
        self.valor_bc_retencao_icms = data.get('valorBcRetencaoIcms')
        self.aliquota_retencao_icms = data.get('aliquotaRetencaoIcms')
        self.valor_icms_retido = data.get('valorIcmsRetido')
        self.cfop = data.get('cfop')
        self.municipio = data.get('municipio')
        self.placa_veiculo = data.get('placaVeiculo')
        self.uf_veiculo = data.get('ufVeiculo')
        self.rntc_veiculo = data.get('rntcVeiculo')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeCabecalho': self.id_nfe_cabecalho,
            'idTransportadora': self.id_transportadora,
            'modalidadeFrete': self.modalidade_frete,
            'cnpj': self.cnpj,
            'cpf': self.cpf,
            'nome': self.nome,
            'inscricaoEstadual': self.inscricao_estadual,
            'endereco': self.endereco,
            'nomeMunicipio': self.nome_municipio,
            'uf': self.uf,
            'valorServico': self.valor_servico,
            'valorBcRetencaoIcms': self.valor_bc_retencao_icms,
            'aliquotaRetencaoIcms': self.aliquota_retencao_icms,
            'valorIcmsRetido': self.valor_icms_retido,
            'cfop': self.cfop,
            'municipio': self.municipio,
            'placaVeiculo': self.placa_veiculo,
            'ufVeiculo': self.uf_veiculo,
            'rntcVeiculo': self.rntc_veiculo,
        }