from src import db


class CteInformacaoNfOutrosModel(db.Model):
    __tablename__ = 'cte_informacao_nf_outros'

    id = db.Column(db.Integer, primary_key=True)
    numero_romaneio = db.Column(db.String(20))
    numero_pedido = db.Column(db.String(20))
    chave_acesso_nfe = db.Column(db.String(44))
    codigo_modelo = db.Column(db.String(2))
    serie = db.Column(db.String(3))
    numero = db.Column(db.String(20))
    data_emissao = db.Column(db.DateTime)
    uf_emitente = db.Column(db.Integer)
    base_calculo_icms = db.Column(db.Float)
    valor_icms = db.Column(db.Float)
    base_calculo_icms_st = db.Column(db.Float)
    valor_icms_st = db.Column(db.Float)
    valor_total_produtos = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    cfop_predominante = db.Column(db.Integer)
    peso_total_kg = db.Column(db.Float)
    pin_suframa = db.Column(db.Integer)
    data_prevista_entrega = db.Column(db.DateTime)
    outro_tipo_doc_orig = db.Column(db.String(2))
    outro_descricao = db.Column(db.String(100))
    outro_valor_documento = db.Column(db.Float)
    id_cte_cabecalho = db.Column(db.Integer, db.ForeignKey('cte_cabecalho.id'))


    def mapping(self, data):
        self.id = data.get('id')
        self.id_cte_cabecalho = data.get('idCteCabecalho')
        self.numero_romaneio = data.get('numeroRomaneio')
        self.numero_pedido = data.get('numeroPedido')
        self.chave_acesso_nfe = data.get('chaveAcessoNfe')
        self.codigo_modelo = data.get('codigoModelo')
        self.serie = data.get('serie')
        self.numero = data.get('numero')
        self.data_emissao = data.get('dataEmissao')
        self.uf_emitente = data.get('ufEmitente')
        self.base_calculo_icms = data.get('baseCalculoIcms')
        self.valor_icms = data.get('valorIcms')
        self.base_calculo_icms_st = data.get('baseCalculoIcmsSt')
        self.valor_icms_st = data.get('valorIcmsSt')
        self.valor_total_produtos = data.get('valorTotalProdutos')
        self.valor_total = data.get('valorTotal')
        self.cfop_predominante = data.get('cfopPredominante')
        self.peso_total_kg = data.get('pesoTotalKg')
        self.pin_suframa = data.get('pinSuframa')
        self.data_prevista_entrega = data.get('dataPrevistaEntrega')
        self.outro_tipo_doc_orig = data.get('outroTipoDocOrig')
        self.outro_descricao = data.get('outroDescricao')
        self.outro_valor_documento = data.get('outroValorDocumento')

    def serialize(self):
        return {
            'id': self.id,
            'idCteCabecalho': self.id_cte_cabecalho,
            'numeroRomaneio': self.numero_romaneio,
            'numeroPedido': self.numero_pedido,
            'chaveAcessoNfe': self.chave_acesso_nfe,
            'codigoModelo': self.codigo_modelo,
            'serie': self.serie,
            'numero': self.numero,
            'dataEmissao': self.data_emissao.isoformat(),
            'ufEmitente': self.uf_emitente,
            'baseCalculoIcms': self.base_calculo_icms,
            'valorIcms': self.valor_icms,
            'baseCalculoIcmsSt': self.base_calculo_icms_st,
            'valorIcmsSt': self.valor_icms_st,
            'valorTotalProdutos': self.valor_total_produtos,
            'valorTotal': self.valor_total,
            'cfopPredominante': self.cfop_predominante,
            'pesoTotalKg': self.peso_total_kg,
            'pinSuframa': self.pin_suframa,
            'dataPrevistaEntrega': self.data_prevista_entrega.isoformat(),
            'outroTipoDocOrig': self.outro_tipo_doc_orig,
            'outroDescricao': self.outro_descricao,
            'outroValorDocumento': self.outro_valor_documento,
        }