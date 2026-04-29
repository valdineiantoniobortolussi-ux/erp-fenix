from src import db


class NfeCabecalhoModel(db.Model):
    __tablename__ = 'nfe_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    id_vendedor = db.Column(db.Integer)
    uf_emitente = db.Column(db.Integer)
    codigo_numerico = db.Column(db.String(8))
    natureza_operacao = db.Column(db.String(60))
    codigo_modelo = db.Column(db.String(2))
    serie = db.Column(db.String(3))
    numero = db.Column(db.String(9))
    data_hora_emissao = db.Column(db.DateTime)
    data_hora_entrada_saida = db.Column(db.DateTime)
    tipo_operacao = db.Column(db.String(1))
    local_destino = db.Column(db.String(1))
    codigo_municipio = db.Column(db.Integer)
    formato_impressao_danfe = db.Column(db.String(1))
    tipo_emissao = db.Column(db.String(1))
    chave_acesso = db.Column(db.String(44))
    digito_chave_acesso = db.Column(db.String(1))
    ambiente = db.Column(db.String(1))
    finalidade_emissao = db.Column(db.String(1))
    consumidor_operacao = db.Column(db.String(1))
    consumidor_presenca = db.Column(db.String(1))
    processo_emissao = db.Column(db.String(1))
    versao_processo_emissao = db.Column(db.String(20))
    data_entrada_contingencia = db.Column(db.DateTime)
    justificativa_contingencia = db.Column(db.String(255))
    base_calculo_icms = db.Column(db.Float)
    valor_icms = db.Column(db.Float)
    valor_icms_desonerado = db.Column(db.Float)
    total_icms_fcp_uf_destino = db.Column(db.Float)
    total_icms_interestadual_uf_destino = db.Column(db.Float)
    total_icms_interestadual_uf_remetente = db.Column(db.Float)
    valor_total_fcp = db.Column(db.Float)
    base_calculo_icms_st = db.Column(db.Float)
    valor_icms_st = db.Column(db.Float)
    valor_total_fcp_st = db.Column(db.Float)
    valor_total_fcp_st_retido = db.Column(db.Float)
    valor_total_produtos = db.Column(db.Float)
    valor_frete = db.Column(db.Float)
    valor_seguro = db.Column(db.Float)
    valor_desconto = db.Column(db.Float)
    valor_imposto_importacao = db.Column(db.Float)
    valor_ipi = db.Column(db.Float)
    valor_ipi_devolvido = db.Column(db.Float)
    valor_pis = db.Column(db.Float)
    valor_cofins = db.Column(db.Float)
    valor_despesas_acessorias = db.Column(db.Float)
    valor_total = db.Column(db.Float)
    valor_total_tributos = db.Column(db.Float)
    valor_servicos = db.Column(db.Float)
    base_calculo_issqn = db.Column(db.Float)
    valor_issqn = db.Column(db.Float)
    valor_pis_issqn = db.Column(db.Float)
    valor_cofins_issqn = db.Column(db.Float)
    data_prestacao_servico = db.Column(db.DateTime)
    valor_deducao_issqn = db.Column(db.Float)
    outras_retencoes_issqn = db.Column(db.Float)
    desconto_incondicionado_issqn = db.Column(db.Float)
    desconto_condicionado_issqn = db.Column(db.Float)
    total_retencao_issqn = db.Column(db.Float)
    regime_especial_tributacao = db.Column(db.String(1))
    valor_retido_pis = db.Column(db.Float)
    valor_retido_cofins = db.Column(db.Float)
    valor_retido_csll = db.Column(db.Float)
    base_calculo_irrf = db.Column(db.Float)
    valor_retido_irrf = db.Column(db.Float)
    base_calculo_previdencia = db.Column(db.Float)
    valor_retido_previdencia = db.Column(db.Float)
    informacoes_add_fisco = db.Column(db.Text)
    informacoes_add_contribuinte = db.Column(db.Text)
    comex_uf_embarque = db.Column(db.String(2))
    comex_local_embarque = db.Column(db.String(60))
    comex_local_despacho = db.Column(db.String(60))
    compra_nota_empenho = db.Column(db.String(22))
    compra_pedido = db.Column(db.String(60))
    compra_contrato = db.Column(db.String(60))
    qrcode = db.Column(db.Text)
    url_chave = db.Column(db.String(85))
    status_nota = db.Column(db.String(1))
    id_fornecedor = db.Column(db.Integer)
    id_nfce_movimento = db.Column(db.Integer)
    id_venda_cabecalho = db.Column(db.Integer)
    id_tribut_operacao_fiscal = db.Column(db.Integer)
    id_cliente = db.Column(db.Integer)


    def mapping(self, data):
        self.id = data.get('id')
        self.id_vendedor = data.get('idVendedor')
        self.uf_emitente = data.get('ufEmitente')
        self.codigo_numerico = data.get('codigoNumerico')
        self.natureza_operacao = data.get('naturezaOperacao')
        self.codigo_modelo = data.get('codigoModelo')
        self.serie = data.get('serie')
        self.numero = data.get('numero')
        self.data_hora_emissao = data.get('dataHoraEmissao')
        self.data_hora_entrada_saida = data.get('dataHoraEntradaSaida')
        self.tipo_operacao = data.get('tipoOperacao')
        self.local_destino = data.get('localDestino')
        self.codigo_municipio = data.get('codigoMunicipio')
        self.formato_impressao_danfe = data.get('formatoImpressaoDanfe')
        self.tipo_emissao = data.get('tipoEmissao')
        self.chave_acesso = data.get('chaveAcesso')
        self.digito_chave_acesso = data.get('digitoChaveAcesso')
        self.ambiente = data.get('ambiente')
        self.finalidade_emissao = data.get('finalidadeEmissao')
        self.consumidor_operacao = data.get('consumidorOperacao')
        self.consumidor_presenca = data.get('consumidorPresenca')
        self.processo_emissao = data.get('processoEmissao')
        self.versao_processo_emissao = data.get('versaoProcessoEmissao')
        self.data_entrada_contingencia = data.get('dataEntradaContingencia')
        self.justificativa_contingencia = data.get('justificativaContingencia')
        self.base_calculo_icms = data.get('baseCalculoIcms')
        self.valor_icms = data.get('valorIcms')
        self.valor_icms_desonerado = data.get('valorIcmsDesonerado')
        self.total_icms_fcp_uf_destino = data.get('totalIcmsFcpUfDestino')
        self.total_icms_interestadual_uf_destino = data.get('totalIcmsInterestadualUfDestino')
        self.total_icms_interestadual_uf_remetente = data.get('totalIcmsInterestadualUfRemetente')
        self.valor_total_fcp = data.get('valorTotalFcp')
        self.base_calculo_icms_st = data.get('baseCalculoIcmsSt')
        self.valor_icms_st = data.get('valorIcmsSt')
        self.valor_total_fcp_st = data.get('valorTotalFcpSt')
        self.valor_total_fcp_st_retido = data.get('valorTotalFcpStRetido')
        self.valor_total_produtos = data.get('valorTotalProdutos')
        self.valor_frete = data.get('valorFrete')
        self.valor_seguro = data.get('valorSeguro')
        self.valor_desconto = data.get('valorDesconto')
        self.valor_imposto_importacao = data.get('valorImpostoImportacao')
        self.valor_ipi = data.get('valorIpi')
        self.valor_ipi_devolvido = data.get('valorIpiDevolvido')
        self.valor_pis = data.get('valorPis')
        self.valor_cofins = data.get('valorCofins')
        self.valor_despesas_acessorias = data.get('valorDespesasAcessorias')
        self.valor_total = data.get('valorTotal')
        self.valor_total_tributos = data.get('valorTotalTributos')
        self.valor_servicos = data.get('valorServicos')
        self.base_calculo_issqn = data.get('baseCalculoIssqn')
        self.valor_issqn = data.get('valorIssqn')
        self.valor_pis_issqn = data.get('valorPisIssqn')
        self.valor_cofins_issqn = data.get('valorCofinsIssqn')
        self.data_prestacao_servico = data.get('dataPrestacaoServico')
        self.valor_deducao_issqn = data.get('valorDeducaoIssqn')
        self.outras_retencoes_issqn = data.get('outrasRetencoesIssqn')
        self.desconto_incondicionado_issqn = data.get('descontoIncondicionadoIssqn')
        self.desconto_condicionado_issqn = data.get('descontoCondicionadoIssqn')
        self.total_retencao_issqn = data.get('totalRetencaoIssqn')
        self.regime_especial_tributacao = data.get('regimeEspecialTributacao')
        self.valor_retido_pis = data.get('valorRetidoPis')
        self.valor_retido_cofins = data.get('valorRetidoCofins')
        self.valor_retido_csll = data.get('valorRetidoCsll')
        self.base_calculo_irrf = data.get('baseCalculoIrrf')
        self.valor_retido_irrf = data.get('valorRetidoIrrf')
        self.base_calculo_previdencia = data.get('baseCalculoPrevidencia')
        self.valor_retido_previdencia = data.get('valorRetidoPrevidencia')
        self.informacoes_add_fisco = data.get('informacoesAddFisco')
        self.informacoes_add_contribuinte = data.get('informacoesAddContribuinte')
        self.comex_uf_embarque = data.get('comexUfEmbarque')
        self.comex_local_embarque = data.get('comexLocalEmbarque')
        self.comex_local_despacho = data.get('comexLocalDespacho')
        self.compra_nota_empenho = data.get('compraNotaEmpenho')
        self.compra_pedido = data.get('compraPedido')
        self.compra_contrato = data.get('compraContrato')
        self.qrcode = data.get('qrcode')
        self.url_chave = data.get('urlChave')
        self.status_nota = data.get('statusNota')
        self.id_fornecedor = data.get('idFornecedor')
        self.id_nfce_movimento = data.get('idNfceMovimento')
        self.id_venda_cabecalho = data.get('idVendaCabecalho')
        self.id_tribut_operacao_fiscal = data.get('idTributOperacaoFiscal')
        self.id_cliente = data.get('idCliente')

    def serialize(self):
        return {
            'id': self.id,
            'idVendedor': self.id_vendedor,
            'ufEmitente': self.uf_emitente,
            'codigoNumerico': self.codigo_numerico,
            'naturezaOperacao': self.natureza_operacao,
            'codigoModelo': self.codigo_modelo,
            'serie': self.serie,
            'numero': self.numero,
            'dataHoraEmissao': self.data_hora_emissao.isoformat(),
            'dataHoraEntradaSaida': self.data_hora_entrada_saida.isoformat(),
            'tipoOperacao': self.tipo_operacao,
            'localDestino': self.local_destino,
            'codigoMunicipio': self.codigo_municipio,
            'formatoImpressaoDanfe': self.formato_impressao_danfe,
            'tipoEmissao': self.tipo_emissao,
            'chaveAcesso': self.chave_acesso,
            'digitoChaveAcesso': self.digito_chave_acesso,
            'ambiente': self.ambiente,
            'finalidadeEmissao': self.finalidade_emissao,
            'consumidorOperacao': self.consumidor_operacao,
            'consumidorPresenca': self.consumidor_presenca,
            'processoEmissao': self.processo_emissao,
            'versaoProcessoEmissao': self.versao_processo_emissao,
            'dataEntradaContingencia': self.data_entrada_contingencia.isoformat(),
            'justificativaContingencia': self.justificativa_contingencia,
            'baseCalculoIcms': self.base_calculo_icms,
            'valorIcms': self.valor_icms,
            'valorIcmsDesonerado': self.valor_icms_desonerado,
            'totalIcmsFcpUfDestino': self.total_icms_fcp_uf_destino,
            'totalIcmsInterestadualUfDestino': self.total_icms_interestadual_uf_destino,
            'totalIcmsInterestadualUfRemetente': self.total_icms_interestadual_uf_remetente,
            'valorTotalFcp': self.valor_total_fcp,
            'baseCalculoIcmsSt': self.base_calculo_icms_st,
            'valorIcmsSt': self.valor_icms_st,
            'valorTotalFcpSt': self.valor_total_fcp_st,
            'valorTotalFcpStRetido': self.valor_total_fcp_st_retido,
            'valorTotalProdutos': self.valor_total_produtos,
            'valorFrete': self.valor_frete,
            'valorSeguro': self.valor_seguro,
            'valorDesconto': self.valor_desconto,
            'valorImpostoImportacao': self.valor_imposto_importacao,
            'valorIpi': self.valor_ipi,
            'valorIpiDevolvido': self.valor_ipi_devolvido,
            'valorPis': self.valor_pis,
            'valorCofins': self.valor_cofins,
            'valorDespesasAcessorias': self.valor_despesas_acessorias,
            'valorTotal': self.valor_total,
            'valorTotalTributos': self.valor_total_tributos,
            'valorServicos': self.valor_servicos,
            'baseCalculoIssqn': self.base_calculo_issqn,
            'valorIssqn': self.valor_issqn,
            'valorPisIssqn': self.valor_pis_issqn,
            'valorCofinsIssqn': self.valor_cofins_issqn,
            'dataPrestacaoServico': self.data_prestacao_servico.isoformat(),
            'valorDeducaoIssqn': self.valor_deducao_issqn,
            'outrasRetencoesIssqn': self.outras_retencoes_issqn,
            'descontoIncondicionadoIssqn': self.desconto_incondicionado_issqn,
            'descontoCondicionadoIssqn': self.desconto_condicionado_issqn,
            'totalRetencaoIssqn': self.total_retencao_issqn,
            'regimeEspecialTributacao': self.regime_especial_tributacao,
            'valorRetidoPis': self.valor_retido_pis,
            'valorRetidoCofins': self.valor_retido_cofins,
            'valorRetidoCsll': self.valor_retido_csll,
            'baseCalculoIrrf': self.base_calculo_irrf,
            'valorRetidoIrrf': self.valor_retido_irrf,
            'baseCalculoPrevidencia': self.base_calculo_previdencia,
            'valorRetidoPrevidencia': self.valor_retido_previdencia,
            'informacoesAddFisco': self.informacoes_add_fisco,
            'informacoesAddContribuinte': self.informacoes_add_contribuinte,
            'comexUfEmbarque': self.comex_uf_embarque,
            'comexLocalEmbarque': self.comex_local_embarque,
            'comexLocalDespacho': self.comex_local_despacho,
            'compraNotaEmpenho': self.compra_nota_empenho,
            'compraPedido': self.compra_pedido,
            'compraContrato': self.compra_contrato,
            'qrcode': self.qrcode,
            'urlChave': self.url_chave,
            'statusNota': self.status_nota,
            'idFornecedor': self.id_fornecedor,
            'idNfceMovimento': self.id_nfce_movimento,
            'idVendaCabecalho': self.id_venda_cabecalho,
            'idTributOperacaoFiscal': self.id_tribut_operacao_fiscal,
            'idCliente': self.id_cliente,
        }