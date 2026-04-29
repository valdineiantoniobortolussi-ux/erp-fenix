from src import db


class NfeDetalheImpostoIssqnModel(db.Model):
    __tablename__ = 'nfe_detalhe_imposto_issqn'

    id = db.Column(db.Integer, primary_key=True)
    base_calculo_issqn = db.Column(db.Float)
    aliquota_issqn = db.Column(db.Float)
    valor_issqn = db.Column(db.Float)
    municipio_issqn = db.Column(db.Integer)
    item_lista_servicos = db.Column(db.Integer)
    valor_deducao = db.Column(db.Float)
    valor_outras_retencoes = db.Column(db.Float)
    valor_desconto_incondicionado = db.Column(db.Float)
    valor_desconto_condicionado = db.Column(db.Float)
    valor_retencao_iss = db.Column(db.Float)
    indicador_exigibilidade_iss = db.Column(db.String(1))
    codigo_servico = db.Column(db.String(20))
    municipio_incidencia = db.Column(db.Integer)
    pais_sevico_prestado = db.Column(db.Integer)
    numero_processo = db.Column(db.String(30))
    indicador_incentivo_fiscal = db.Column(db.String(1))
    id_nfe_detalhe = db.Column(db.Integer, db.ForeignKey('nfe_detalhe.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_nfe_detalhe = data.get('idNfeDetalhe')
        self.base_calculo_issqn = data.get('baseCalculoIssqn')
        self.aliquota_issqn = data.get('aliquotaIssqn')
        self.valor_issqn = data.get('valorIssqn')
        self.municipio_issqn = data.get('municipioIssqn')
        self.item_lista_servicos = data.get('itemListaServicos')
        self.valor_deducao = data.get('valorDeducao')
        self.valor_outras_retencoes = data.get('valorOutrasRetencoes')
        self.valor_desconto_incondicionado = data.get('valorDescontoIncondicionado')
        self.valor_desconto_condicionado = data.get('valorDescontoCondicionado')
        self.valor_retencao_iss = data.get('valorRetencaoIss')
        self.indicador_exigibilidade_iss = data.get('indicadorExigibilidadeIss')
        self.codigo_servico = data.get('codigoServico')
        self.municipio_incidencia = data.get('municipioIncidencia')
        self.pais_sevico_prestado = data.get('paisSevicoPrestado')
        self.numero_processo = data.get('numeroProcesso')
        self.indicador_incentivo_fiscal = data.get('indicadorIncentivoFiscal')

    def serialize(self):
        return {
            'id': self.id,
            'idNfeDetalhe': self.id_nfe_detalhe,
            'baseCalculoIssqn': self.base_calculo_issqn,
            'aliquotaIssqn': self.aliquota_issqn,
            'valorIssqn': self.valor_issqn,
            'municipioIssqn': self.municipio_issqn,
            'itemListaServicos': self.item_lista_servicos,
            'valorDeducao': self.valor_deducao,
            'valorOutrasRetencoes': self.valor_outras_retencoes,
            'valorDescontoIncondicionado': self.valor_desconto_incondicionado,
            'valorDescontoCondicionado': self.valor_desconto_condicionado,
            'valorRetencaoIss': self.valor_retencao_iss,
            'indicadorExigibilidadeIss': self.indicador_exigibilidade_iss,
            'codigoServico': self.codigo_servico,
            'municipioIncidencia': self.municipio_incidencia,
            'paisSevicoPrestado': self.pais_sevico_prestado,
            'numeroProcesso': self.numero_processo,
            'indicadorIncentivoFiscal': self.indicador_incentivo_fiscal,
        }