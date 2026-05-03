import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';

@DataClassName("NfeCabecalho")
class NfeCabecalhos extends Table {
	@override
	String get tableName => 'nfe_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idVendedor => integer().named('id_vendedor').nullable()();
	IntColumn get ufEmitente => integer().named('uf_emitente').nullable()();
	TextColumn get codigoNumerico => text().named('codigo_numerico').withLength(min: 0, max: 8).nullable()();
	TextColumn get naturezaOperacao => text().named('natureza_operacao').withLength(min: 0, max: 60).nullable()();
	TextColumn get codigoModelo => text().named('codigo_modelo').withLength(min: 0, max: 2).nullable()();
	TextColumn get serie => text().named('serie').withLength(min: 0, max: 3).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 9).nullable()();
	DateTimeColumn get dataHoraEmissao => dateTime().named('data_hora_emissao').nullable()();
	DateTimeColumn get dataHoraEntradaSaida => dateTime().named('data_hora_entrada_saida').nullable()();
	TextColumn get tipoOperacao => text().named('tipo_operacao').withLength(min: 0, max: 1).nullable()();
	TextColumn get localDestino => text().named('local_destino').withLength(min: 0, max: 1).nullable()();
	IntColumn get codigoMunicipio => integer().named('codigo_municipio').nullable()();
	TextColumn get formatoImpressaoDanfe => text().named('formato_impressao_danfe').withLength(min: 0, max: 1).nullable()();
	TextColumn get tipoEmissao => text().named('tipo_emissao').withLength(min: 0, max: 1).nullable()();
	TextColumn get chaveAcesso => text().named('chave_acesso').withLength(min: 0, max: 44).nullable()();
	TextColumn get digitoChaveAcesso => text().named('digito_chave_acesso').withLength(min: 0, max: 1).nullable()();
	TextColumn get ambiente => text().named('ambiente').withLength(min: 0, max: 1).nullable()();
	TextColumn get finalidadeEmissao => text().named('finalidade_emissao').withLength(min: 0, max: 1).nullable()();
	TextColumn get consumidorOperacao => text().named('consumidor_operacao').withLength(min: 0, max: 1).nullable()();
	TextColumn get consumidorPresenca => text().named('consumidor_presenca').withLength(min: 0, max: 1).nullable()();
	TextColumn get processoEmissao => text().named('processo_emissao').withLength(min: 0, max: 1).nullable()();
	TextColumn get versaoProcessoEmissao => text().named('versao_processo_emissao').withLength(min: 0, max: 20).nullable()();
	DateTimeColumn get dataEntradaContingencia => dateTime().named('data_entrada_contingencia').nullable()();
	TextColumn get justificativaContingencia => text().named('justificativa_contingencia').withLength(min: 0, max: 255).nullable()();
	RealColumn get baseCalculoIcms => real().named('base_calculo_icms').nullable()();
	RealColumn get valorIcms => real().named('valor_icms').nullable()();
	RealColumn get valorIcmsDesonerado => real().named('valor_icms_desonerado').nullable()();
	RealColumn get totalIcmsFcpUfDestino => real().named('total_icms_fcp_uf_destino').nullable()();
	RealColumn get totalIcmsInterestadualUfDestino => real().named('total_icms_interestadual_uf_destino').nullable()();
	RealColumn get totalIcmsInterestadualUfRemetente => real().named('total_icms_interestadual_uf_remetente').nullable()();
	RealColumn get valorTotalFcp => real().named('valor_total_fcp').nullable()();
	RealColumn get baseCalculoIcmsSt => real().named('base_calculo_icms_st').nullable()();
	RealColumn get valorIcmsSt => real().named('valor_icms_st').nullable()();
	RealColumn get valorTotalFcpSt => real().named('valor_total_fcp_st').nullable()();
	RealColumn get valorTotalFcpStRetido => real().named('valor_total_fcp_st_retido').nullable()();
	RealColumn get valorTotalProdutos => real().named('valor_total_produtos').nullable()();
	RealColumn get valorFrete => real().named('valor_frete').nullable()();
	RealColumn get valorSeguro => real().named('valor_seguro').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorImpostoImportacao => real().named('valor_imposto_importacao').nullable()();
	RealColumn get valorIpi => real().named('valor_ipi').nullable()();
	RealColumn get valorIpiDevolvido => real().named('valor_ipi_devolvido').nullable()();
	RealColumn get valorPis => real().named('valor_pis').nullable()();
	RealColumn get valorCofins => real().named('valor_cofins').nullable()();
	RealColumn get valorDespesasAcessorias => real().named('valor_despesas_acessorias').nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();
	RealColumn get valorTotalTributos => real().named('valor_total_tributos').nullable()();
	RealColumn get valorServicos => real().named('valor_servicos').nullable()();
	RealColumn get baseCalculoIssqn => real().named('base_calculo_issqn').nullable()();
	RealColumn get valorIssqn => real().named('valor_issqn').nullable()();
	RealColumn get valorPisIssqn => real().named('valor_pis_issqn').nullable()();
	RealColumn get valorCofinsIssqn => real().named('valor_cofins_issqn').nullable()();
	DateTimeColumn get dataPrestacaoServico => dateTime().named('data_prestacao_servico').nullable()();
	RealColumn get valorDeducaoIssqn => real().named('valor_deducao_issqn').nullable()();
	RealColumn get outrasRetencoesIssqn => real().named('outras_retencoes_issqn').nullable()();
	RealColumn get descontoIncondicionadoIssqn => real().named('desconto_incondicionado_issqn').nullable()();
	RealColumn get descontoCondicionadoIssqn => real().named('desconto_condicionado_issqn').nullable()();
	RealColumn get totalRetencaoIssqn => real().named('total_retencao_issqn').nullable()();
	TextColumn get regimeEspecialTributacao => text().named('regime_especial_tributacao').withLength(min: 0, max: 1).nullable()();
	RealColumn get valorRetidoPis => real().named('valor_retido_pis').nullable()();
	RealColumn get valorRetidoCofins => real().named('valor_retido_cofins').nullable()();
	RealColumn get valorRetidoCsll => real().named('valor_retido_csll').nullable()();
	RealColumn get baseCalculoIrrf => real().named('base_calculo_irrf').nullable()();
	RealColumn get valorRetidoIrrf => real().named('valor_retido_irrf').nullable()();
	RealColumn get baseCalculoPrevidencia => real().named('base_calculo_previdencia').nullable()();
	RealColumn get valorRetidoPrevidencia => real().named('valor_retido_previdencia').nullable()();
	TextColumn get informacoesAddFisco => text().named('informacoes_add_fisco').nullable()();
	TextColumn get informacoesAddContribuinte => text().named('informacoes_add_contribuinte').nullable()();
	TextColumn get comexUfEmbarque => text().named('comex_uf_embarque').withLength(min: 0, max: 2).nullable()();
	TextColumn get comexLocalEmbarque => text().named('comex_local_embarque').withLength(min: 0, max: 60).nullable()();
	TextColumn get comexLocalDespacho => text().named('comex_local_despacho').withLength(min: 0, max: 60).nullable()();
	TextColumn get compraNotaEmpenho => text().named('compra_nota_empenho').withLength(min: 0, max: 22).nullable()();
	TextColumn get compraPedido => text().named('compra_pedido').withLength(min: 0, max: 60).nullable()();
	TextColumn get compraContrato => text().named('compra_contrato').withLength(min: 0, max: 60).nullable()();
	TextColumn get qrcode => text().named('qrcode').nullable()();
	TextColumn get urlChave => text().named('url_chave').withLength(min: 0, max: 85).nullable()();
	TextColumn get statusNota => text().named('status_nota').withLength(min: 0, max: 1).nullable()();
	IntColumn get idFornecedor => integer().named('id_fornecedor').nullable()();
	IntColumn get idNfceMovimento => integer().named('id_nfce_movimento').nullable()();
	IntColumn get idVendaCabecalho => integer().named('id_venda_cabecalho').nullable()();
	IntColumn get idTributOperacaoFiscal => integer().named('id_tribut_operacao_fiscal').nullable()();
	IntColumn get idCliente => integer().named('id_cliente').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeCabecalhoGrouped {
	NfeCabecalho? nfeCabecalho; 

  NfeCabecalhoGrouped({
		this.nfeCabecalho, 

  });
}
