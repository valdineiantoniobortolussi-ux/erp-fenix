from src import db


class PatrimBemModel(db.Model):
    __tablename__ = 'patrim_bem'

    id = db.Column(db.Integer, primary_key=True)
    id_centro_resultado = db.Column(db.Integer)
    id_patrim_tipo_aquisicao_bem = db.Column(db.Integer)
    id_patrim_estado_conservacao = db.Column(db.Integer)
    id_patrim_grupo_bem = db.Column(db.Integer)
    id_fornecedor = db.Column(db.Integer)
    id_setor = db.Column(db.Integer)
    numero_nb = db.Column(db.String(20))
    nome = db.Column(db.String(100))
    descricao = db.Column(db.Text)
    numero_serie = db.Column(db.String(50))
    data_aquisicao = db.Column(db.DateTime)
    data_aceite = db.Column(db.DateTime)
    data_cadastro = db.Column(db.DateTime)
    data_contabilizado = db.Column(db.DateTime)
    data_vistoria = db.Column(db.DateTime)
    data_marcacao = db.Column(db.DateTime)
    data_baixa = db.Column(db.DateTime)
    vencimento_garantia = db.Column(db.DateTime)
    numero_nota_fiscal = db.Column(db.String(50))
    chave_nfe = db.Column(db.String(44))
    valor_original = db.Column(db.Float)
    valor_compra = db.Column(db.Float)
    valor_atualizado = db.Column(db.Float)
    valor_baixa = db.Column(db.Float)
    deprecia = db.Column(db.String(1))
    metodo_depreciacao = db.Column(db.String(1))
    inicio_depreciacao = db.Column(db.DateTime)
    ultima_depreciacao = db.Column(db.DateTime)
    tipo_depreciacao = db.Column(db.String(1))
    taxa_anual_depreciacao = db.Column(db.Float)
    taxa_mensal_depreciacao = db.Column(db.Float)
    taxa_depreciacao_acelerada = db.Column(db.Float)
    taxa_depreciacao_incentivada = db.Column(db.Float)
    funcao = db.Column(db.Text)


    def mapping(self, data):
        self.id = data.get('id')
        self.id_centro_resultado = data.get('idCentroResultado')
        self.id_patrim_tipo_aquisicao_bem = data.get('idPatrimTipoAquisicaoBem')
        self.id_patrim_estado_conservacao = data.get('idPatrimEstadoConservacao')
        self.id_patrim_grupo_bem = data.get('idPatrimGrupoBem')
        self.id_fornecedor = data.get('idFornecedor')
        self.id_setor = data.get('idSetor')
        self.numero_nb = data.get('numeroNb')
        self.nome = data.get('nome')
        self.descricao = data.get('descricao')
        self.numero_serie = data.get('numeroSerie')
        self.data_aquisicao = data.get('dataAquisicao')
        self.data_aceite = data.get('dataAceite')
        self.data_cadastro = data.get('dataCadastro')
        self.data_contabilizado = data.get('dataContabilizado')
        self.data_vistoria = data.get('dataVistoria')
        self.data_marcacao = data.get('dataMarcacao')
        self.data_baixa = data.get('dataBaixa')
        self.vencimento_garantia = data.get('vencimentoGarantia')
        self.numero_nota_fiscal = data.get('numeroNotaFiscal')
        self.chave_nfe = data.get('chaveNfe')
        self.valor_original = data.get('valorOriginal')
        self.valor_compra = data.get('valorCompra')
        self.valor_atualizado = data.get('valorAtualizado')
        self.valor_baixa = data.get('valorBaixa')
        self.deprecia = data.get('deprecia')
        self.metodo_depreciacao = data.get('metodoDepreciacao')
        self.inicio_depreciacao = data.get('inicioDepreciacao')
        self.ultima_depreciacao = data.get('ultimaDepreciacao')
        self.tipo_depreciacao = data.get('tipoDepreciacao')
        self.taxa_anual_depreciacao = data.get('taxaAnualDepreciacao')
        self.taxa_mensal_depreciacao = data.get('taxaMensalDepreciacao')
        self.taxa_depreciacao_acelerada = data.get('taxaDepreciacaoAcelerada')
        self.taxa_depreciacao_incentivada = data.get('taxaDepreciacaoIncentivada')
        self.funcao = data.get('funcao')

    def serialize(self):
        return {
            'id': self.id,
            'idCentroResultado': self.id_centro_resultado,
            'idPatrimTipoAquisicaoBem': self.id_patrim_tipo_aquisicao_bem,
            'idPatrimEstadoConservacao': self.id_patrim_estado_conservacao,
            'idPatrimGrupoBem': self.id_patrim_grupo_bem,
            'idFornecedor': self.id_fornecedor,
            'idSetor': self.id_setor,
            'numeroNb': self.numero_nb,
            'nome': self.nome,
            'descricao': self.descricao,
            'numeroSerie': self.numero_serie,
            'dataAquisicao': self.data_aquisicao.isoformat(),
            'dataAceite': self.data_aceite.isoformat(),
            'dataCadastro': self.data_cadastro.isoformat(),
            'dataContabilizado': self.data_contabilizado.isoformat(),
            'dataVistoria': self.data_vistoria.isoformat(),
            'dataMarcacao': self.data_marcacao.isoformat(),
            'dataBaixa': self.data_baixa.isoformat(),
            'vencimentoGarantia': self.vencimento_garantia.isoformat(),
            'numeroNotaFiscal': self.numero_nota_fiscal,
            'chaveNfe': self.chave_nfe,
            'valorOriginal': self.valor_original,
            'valorCompra': self.valor_compra,
            'valorAtualizado': self.valor_atualizado,
            'valorBaixa': self.valor_baixa,
            'deprecia': self.deprecia,
            'metodoDepreciacao': self.metodo_depreciacao,
            'inicioDepreciacao': self.inicio_depreciacao.isoformat(),
            'ultimaDepreciacao': self.ultima_depreciacao.isoformat(),
            'tipoDepreciacao': self.tipo_depreciacao,
            'taxaAnualDepreciacao': self.taxa_anual_depreciacao,
            'taxaMensalDepreciacao': self.taxa_mensal_depreciacao,
            'taxaDepreciacaoAcelerada': self.taxa_depreciacao_acelerada,
            'taxaDepreciacaoIncentivada': self.taxa_depreciacao_incentivada,
            'funcao': self.funcao,
        }