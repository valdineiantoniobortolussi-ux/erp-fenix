import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

@DataClassName("CteCabecalho")
class CteCabecalhos extends Table {
	@override
	String get tableName => 'cte_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get naturezaOperacao => text().named('natureza_operacao').withLength(min: 0, max: 60).nullable()();
	TextColumn get chaveAcesso => text().named('chave_acesso').withLength(min: 0, max: 44).nullable()();
	TextColumn get digitoChaveAcesso => text().named('digito_chave_acesso').withLength(min: 0, max: 1).nullable()();
	TextColumn get codigoNumerico => text().named('codigo_numerico').withLength(min: 0, max: 8).nullable()();
	TextColumn get serie => text().named('serie').withLength(min: 0, max: 3).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 9).nullable()();
	DateTimeColumn get dataHoraEmissao => dateTime().named('data_hora_emissao').nullable()();
	TextColumn get ufEmitente => text().named('uf_emitente').withLength(min: 0, max: 2).nullable()();
	IntColumn get cfop => integer().named('cfop').nullable()();
	TextColumn get formaPagamento => text().named('forma_pagamento').withLength(min: 0, max: 1).nullable()();
	TextColumn get modelo => text().named('modelo').withLength(min: 0, max: 2).nullable()();
	TextColumn get formatoImpressaoDacte => text().named('formato_impressao_dacte').withLength(min: 0, max: 1).nullable()();
	TextColumn get tipoEmissao => text().named('tipo_emissao').withLength(min: 0, max: 1).nullable()();
	TextColumn get ambiente => text().named('ambiente').withLength(min: 0, max: 1).nullable()();
	TextColumn get tipoCte => text().named('tipo_cte').withLength(min: 0, max: 1).nullable()();
	TextColumn get processoEmissao => text().named('processo_emissao').withLength(min: 0, max: 1).nullable()();
	TextColumn get versaoProcessoEmissao => text().named('versao_processo_emissao').withLength(min: 0, max: 20).nullable()();
	TextColumn get chaveReferenciado => text().named('chave_referenciado').withLength(min: 0, max: 44).nullable()();
	IntColumn get codigoMunicipioEnvio => integer().named('codigo_municipio_envio').nullable()();
	TextColumn get nomeMunicipioEnvio => text().named('nome_municipio_envio').withLength(min: 0, max: 60).nullable()();
	TextColumn get ufEnvio => text().named('uf_envio').withLength(min: 0, max: 2).nullable()();
	TextColumn get modal => text().named('modal').withLength(min: 0, max: 1).nullable()();
	TextColumn get tipoServico => text().named('tipo_servico').withLength(min: 0, max: 1).nullable()();
	IntColumn get codigoMunicipioIniPrestacao => integer().named('codigo_municipio_ini_prestacao').nullable()();
	TextColumn get nomeMunicipioIniPrestacao => text().named('nome_municipio_ini_prestacao').withLength(min: 0, max: 60).nullable()();
	TextColumn get ufIniPrestacao => text().named('uf_ini_prestacao').withLength(min: 0, max: 2).nullable()();
	IntColumn get codigoMunicipioFimPrestacao => integer().named('codigo_municipio_fim_prestacao').nullable()();
	TextColumn get nomeMunicipioFimPrestacao => text().named('nome_municipio_fim_prestacao').withLength(min: 0, max: 60).nullable()();
	TextColumn get ufFimPrestacao => text().named('uf_fim_prestacao').withLength(min: 0, max: 2).nullable()();
	TextColumn get retira => text().named('retira').withLength(min: 0, max: 1).nullable()();
	TextColumn get retiraDetalhe => text().named('retira_detalhe').withLength(min: 0, max: 160).nullable()();
	TextColumn get tomador => text().named('tomador').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get dataEntradaContingencia => dateTime().named('data_entrada_contingencia').nullable()();
	TextColumn get justificativaContingencia => text().named('justificativa_contingencia').withLength(min: 0, max: 255).nullable()();
	TextColumn get caracAdicionalTransporte => text().named('carac_adicional_transporte').withLength(min: 0, max: 15).nullable()();
	TextColumn get caracAdicionalServico => text().named('carac_adicional_servico').withLength(min: 0, max: 30).nullable()();
	TextColumn get funcionarioEmissor => text().named('funcionario_emissor').withLength(min: 0, max: 20).nullable()();
	TextColumn get fluxoOrigem => text().named('fluxo_origem').withLength(min: 0, max: 15).nullable()();
	TextColumn get entregaTipoPeriodo => text().named('entrega_tipo_periodo').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get entregaDataProgramada => dateTime().named('entrega_data_programada').nullable()();
	DateTimeColumn get entregaDataInicial => dateTime().named('entrega_data_inicial').nullable()();
	DateTimeColumn get entregaDataFinal => dateTime().named('entrega_data_final').nullable()();
	TextColumn get entregaTipoHora => text().named('entrega_tipo_hora').withLength(min: 0, max: 1).nullable()();
	TextColumn get entregaHoraProgramada => text().named('entrega_hora_programada').withLength(min: 0, max: 8).nullable()();
	TextColumn get entregaHoraInicial => text().named('entrega_hora_inicial').withLength(min: 0, max: 8).nullable()();
	TextColumn get entregaHoraFinal => text().named('entrega_hora_final').withLength(min: 0, max: 8).nullable()();
	TextColumn get municipioOrigemCalculo => text().named('municipio_origem_calculo').withLength(min: 0, max: 40).nullable()();
	TextColumn get municipioDestinoCalculo => text().named('municipio_destino_calculo').withLength(min: 0, max: 40).nullable()();
	TextColumn get observacoesGerais => text().named('observacoes_gerais').nullable()();
	RealColumn get valorTotalServico => real().named('valor_total_servico').nullable()();
	RealColumn get valorReceber => real().named('valor_receber').nullable()();
	TextColumn get cst => text().named('cst').withLength(min: 0, max: 2).nullable()();
	RealColumn get baseCalculoIcms => real().named('base_calculo_icms').nullable()();
	RealColumn get aliquotaIcms => real().named('aliquota_icms').nullable()();
	RealColumn get valorIcms => real().named('valor_icms').nullable()();
	RealColumn get percentualReducaoBcIcms => real().named('percentual_reducao_bc_icms').nullable()();
	RealColumn get valorBcIcmsStRetido => real().named('valor_bc_icms_st_retido').nullable()();
	RealColumn get valorIcmsStRetido => real().named('valor_icms_st_retido').nullable()();
	RealColumn get aliquotaIcmsStRetido => real().named('aliquota_icms_st_retido').nullable()();
	RealColumn get valorCreditoPresumidoIcms => real().named('valor_credito_presumido_icms').nullable()();
	RealColumn get percentualBcIcmsOutraUf => real().named('percentual_bc_icms_outra_uf').nullable()();
	RealColumn get valorBcIcmsOutraUf => real().named('valor_bc_icms_outra_uf').nullable()();
	RealColumn get aliquotaIcmsOutraUf => real().named('aliquota_icms_outra_uf').nullable()();
	RealColumn get valorIcmsOutraUf => real().named('valor_icms_outra_uf').nullable()();
	TextColumn get simplesNacionalIndicador => text().named('simples_nacional_indicador').withLength(min: 0, max: 1).nullable()();
	RealColumn get simplesNacionalTotal => real().named('simples_nacional_total').nullable()();
	TextColumn get informacoesAddFisco => text().named('informacoes_add_fisco').nullable()();
	RealColumn get valorTotalCarga => real().named('valor_total_carga').nullable()();
	TextColumn get produtoPredominante => text().named('produto_predominante').withLength(min: 0, max: 60).nullable()();
	TextColumn get cargaOutrasCaracteristicas => text().named('carga_outras_caracteristicas').withLength(min: 0, max: 30).nullable()();
	IntColumn get modalVersaoLayout => integer().named('modal_versao_layout').nullable()();
	TextColumn get chaveCteSubstituido => text().named('chave_cte_substituido').withLength(min: 0, max: 44).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteCabecalhoGrouped {
	CteCabecalho? cteCabecalho; 
	List<CteEmitenteGrouped>? cteEmitenteGroupedList; 
	List<CteLocalColetaGrouped>? cteLocalColetaGroupedList; 
	List<CteTomadorGrouped>? cteTomadorGroupedList; 
	List<CtePassagemGrouped>? ctePassagemGroupedList; 
	List<CteRemetenteGrouped>? cteRemetenteGroupedList; 
	List<CteExpedidorGrouped>? cteExpedidorGroupedList; 
	List<CteRecebedorGrouped>? cteRecebedorGroupedList; 
	List<CteDestinatarioGrouped>? cteDestinatarioGroupedList; 
	List<CteLocalEntregaGrouped>? cteLocalEntregaGroupedList; 
	List<CteComponenteGrouped>? cteComponenteGroupedList; 
	List<CteCargaGrouped>? cteCargaGroupedList; 
	List<CteInformacaoNfOutrosGrouped>? cteInformacaoNfOutrosGroupedList; 
	List<CteSeguroGrouped>? cteSeguroGroupedList; 
	List<CtePerigosoGrouped>? ctePerigosoGroupedList; 
	List<CteVeiculoNovoGrouped>? cteVeiculoNovoGroupedList; 
	List<CteFaturaGrouped>? cteFaturaGroupedList; 
	List<CteDuplicataGrouped>? cteDuplicataGroupedList; 
	List<CteRodoviarioGrouped>? cteRodoviarioGroupedList; 
	List<CteAereoGrouped>? cteAereoGroupedList; 
	List<CteAquaviarioGrouped>? cteAquaviarioGroupedList; 
	List<CteFerroviarioGrouped>? cteFerroviarioGroupedList; 
	List<CteDutoviarioGrouped>? cteDutoviarioGroupedList; 
	List<CteMultimodalGrouped>? cteMultimodalGroupedList; 

  CteCabecalhoGrouped({
		this.cteCabecalho, 
		this.cteEmitenteGroupedList, 
		this.cteLocalColetaGroupedList, 
		this.cteTomadorGroupedList, 
		this.ctePassagemGroupedList, 
		this.cteRemetenteGroupedList, 
		this.cteExpedidorGroupedList, 
		this.cteRecebedorGroupedList, 
		this.cteDestinatarioGroupedList, 
		this.cteLocalEntregaGroupedList, 
		this.cteComponenteGroupedList, 
		this.cteCargaGroupedList, 
		this.cteInformacaoNfOutrosGroupedList, 
		this.cteSeguroGroupedList, 
		this.ctePerigosoGroupedList, 
		this.cteVeiculoNovoGroupedList, 
		this.cteFaturaGroupedList, 
		this.cteDuplicataGroupedList, 
		this.cteRodoviarioGroupedList, 
		this.cteAereoGroupedList, 
		this.cteAquaviarioGroupedList, 
		this.cteFerroviarioGroupedList, 
		this.cteDutoviarioGroupedList, 
		this.cteMultimodalGroupedList, 

  });
}
