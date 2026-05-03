from src import db
from src.model.nfe_referenciada_model import NfeReferenciadaModel
from src.model.nfe_emitente_model import NfeEmitenteModel
from src.model.nfe_destinatario_model import NfeDestinatarioModel
from src.model.nfe_local_retirada_model import NfeLocalRetiradaModel
from src.model.nfe_local_entrega_model import NfeLocalEntregaModel
from src.model.nfe_transporte_model import NfeTransporteModel
from src.model.nfe_fatura_model import NfeFaturaModel
from src.model.nfe_cana_model import NfeCanaModel
from src.model.nfe_prod_rural_referenciada_model import NfeProdRuralReferenciadaModel
from src.model.nfe_nf_referenciada_model import NfeNfReferenciadaModel
from src.model.nfe_processo_referenciado_model import NfeProcessoReferenciadoModel
from src.model.nfe_acesso_xml_model import NfeAcessoXmlModel
from src.model.nfe_informacao_pagamento_model import NfeInformacaoPagamentoModel
from src.model.nfe_responsavel_tecnico_model import NfeResponsavelTecnicoModel
from src.model.tribut_operacao_fiscal_model import TributOperacaoFiscalModel
from src.model.venda_cabecalho_model import VendaCabecalhoModel
from src.model.view_pessoa_cliente_model import ViewPessoaClienteModel
from src.model.view_pessoa_colaborador_model import ViewPessoaColaboradorModel
from src.model.view_pessoa_fornecedor_model import ViewPessoaFornecedorModel
from src.model.nfe_cte_referenciado_model import NfeCteReferenciadoModel
from src.model.nfe_cupom_fiscal_referenciado_model import NfeCupomFiscalReferenciadoModel


class NfeCabecalhoModel(db.Model):
    __tablename__ = 'nfe_cabecalho'

    id = db.Column(db.Integer, primary_key=True)
    uf_emitente = db.Column(db.String(2))
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
    id_tribut_operacao_fiscal = db.Column(db.Integer, db.ForeignKey('tribut_operacao_fiscal.id'))
    id_venda_cabecalho = db.Column(db.Integer, db.ForeignKey('venda_cabecalho.id'))
    id_cliente = db.Column(db.Integer, db.ForeignKey('view_pessoa_cliente.id'))
    id_colaborador = db.Column(db.Integer, db.ForeignKey('view_pessoa_colaborador.id'))
    id_fornecedor = db.Column(db.Integer, db.ForeignKey('view_pessoa_fornecedor.id'))

    nfe_referenciada_model_list = db.relationship('NfeReferenciadaModel', lazy='dynamic')
    nfe_emitente_model_list = db.relationship('NfeEmitenteModel', lazy='dynamic')
    nfe_destinatario_model_list = db.relationship('NfeDestinatarioModel', lazy='dynamic')
    nfe_local_retirada_model_list = db.relationship('NfeLocalRetiradaModel', lazy='dynamic')
    nfe_local_entrega_model_list = db.relationship('NfeLocalEntregaModel', lazy='dynamic')
    nfe_transporte_model_list = db.relationship('NfeTransporteModel', lazy='dynamic')
    nfe_fatura_model_list = db.relationship('NfeFaturaModel', lazy='dynamic')
    nfe_cana_model_list = db.relationship('NfeCanaModel', lazy='dynamic')
    nfe_prod_rural_referenciada_model_list = db.relationship('NfeProdRuralReferenciadaModel', lazy='dynamic')
    nfe_nf_referenciada_model_list = db.relationship('NfeNfReferenciadaModel', lazy='dynamic')
    nfe_processo_referenciado_model_list = db.relationship('NfeProcessoReferenciadoModel', lazy='dynamic')
    nfe_acesso_xml_model_list = db.relationship('NfeAcessoXmlModel', lazy='dynamic')
    nfe_informacao_pagamento_model_list = db.relationship('NfeInformacaoPagamentoModel', lazy='dynamic')
    nfe_responsavel_tecnico_model_list = db.relationship('NfeResponsavelTecnicoModel', lazy='dynamic')
    tribut_operacao_fiscal_model = db.relationship('TributOperacaoFiscalModel', foreign_keys=[id_tribut_operacao_fiscal])
    venda_cabecalho_model = db.relationship('VendaCabecalhoModel', foreign_keys=[id_venda_cabecalho])
    view_pessoa_cliente_model = db.relationship('ViewPessoaClienteModel', foreign_keys=[id_cliente])
    view_pessoa_colaborador_model = db.relationship('ViewPessoaColaboradorModel', foreign_keys=[id_colaborador])
    view_pessoa_fornecedor_model = db.relationship('ViewPessoaFornecedorModel', foreign_keys=[id_fornecedor])
    nfe_cte_referenciado_model_list = db.relationship('NfeCteReferenciadoModel', lazy='dynamic')
    nfe_cupom_fiscal_referenciado_model_list = db.relationship('NfeCupomFiscalReferenciadoModel', lazy='dynamic')

    def mapping(self, data):
        self.id = data.get('id')
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
        self.id_venda_cabecalho = data.get('idVendaCabecalho')
        self.id_tribut_operacao_fiscal = data.get('idTributOperacaoFiscal')
        self.id_cliente = data.get('idCliente')
        self.id_colaborador = data.get('idColaborador')
        self.id_fornecedor = data.get('idFornecedor')

    def serialize(self):
        return {
            'id': self.id,
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
            'idVendaCabecalho': self.id_venda_cabecalho,
            'idTributOperacaoFiscal': self.id_tribut_operacao_fiscal,
            'idCliente': self.id_cliente,
            'idColaborador': self.id_colaborador,
            'idFornecedor': self.id_fornecedor,
            'nfeReferenciadaModelList': [nfe_referenciada_model.serialize() for nfe_referenciada_model in self.nfe_referenciada_model_list],
            'nfeEmitenteModelList': [nfe_emitente_model.serialize() for nfe_emitente_model in self.nfe_emitente_model_list],
            'nfeDestinatarioModelList': [nfe_destinatario_model.serialize() for nfe_destinatario_model in self.nfe_destinatario_model_list],
            'nfeLocalRetiradaModelList': [nfe_local_retirada_model.serialize() for nfe_local_retirada_model in self.nfe_local_retirada_model_list],
            'nfeLocalEntregaModelList': [nfe_local_entrega_model.serialize() for nfe_local_entrega_model in self.nfe_local_entrega_model_list],
            'nfeTransporteModelList': [nfe_transporte_model.serialize() for nfe_transporte_model in self.nfe_transporte_model_list],
            'nfeFaturaModelList': [nfe_fatura_model.serialize() for nfe_fatura_model in self.nfe_fatura_model_list],
            'nfeCanaModelList': [nfe_cana_model.serialize() for nfe_cana_model in self.nfe_cana_model_list],
            'nfeProdRuralReferenciadaModelList': [nfe_prod_rural_referenciada_model.serialize() for nfe_prod_rural_referenciada_model in self.nfe_prod_rural_referenciada_model_list],
            'nfeNfReferenciadaModelList': [nfe_nf_referenciada_model.serialize() for nfe_nf_referenciada_model in self.nfe_nf_referenciada_model_list],
            'nfeProcessoReferenciadoModelList': [nfe_processo_referenciado_model.serialize() for nfe_processo_referenciado_model in self.nfe_processo_referenciado_model_list],
            'nfeAcessoXmlModelList': [nfe_acesso_xml_model.serialize() for nfe_acesso_xml_model in self.nfe_acesso_xml_model_list],
            'nfeInformacaoPagamentoModelList': [nfe_informacao_pagamento_model.serialize() for nfe_informacao_pagamento_model in self.nfe_informacao_pagamento_model_list],
            'nfeResponsavelTecnicoModelList': [nfe_responsavel_tecnico_model.serialize() for nfe_responsavel_tecnico_model in self.nfe_responsavel_tecnico_model_list],
            'tributOperacaoFiscalModel': self.tribut_operacao_fiscal_model.serialize() if self.tribut_operacao_fiscal_model else None,
            'vendaCabecalhoModel': self.venda_cabecalho_model.serialize() if self.venda_cabecalho_model else None,
            'viewPessoaClienteModel': self.view_pessoa_cliente_model.serialize() if self.view_pessoa_cliente_model else None,
            'viewPessoaColaboradorModel': self.view_pessoa_colaborador_model.serialize() if self.view_pessoa_colaborador_model else None,
            'viewPessoaFornecedorModel': self.view_pessoa_fornecedor_model.serialize() if self.view_pessoa_fornecedor_model else None,
            'nfeCteReferenciadoModelList': [nfe_cte_referenciado_model.serialize() for nfe_cte_referenciado_model in self.nfe_cte_referenciado_model_list],
            'nfeCupomFiscalReferenciadoModelList': [nfe_cupom_fiscal_referenciado_model.serialize() for nfe_cupom_fiscal_referenciado_model in self.nfe_cupom_fiscal_referenciado_model_list],
        }