import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetalheImpostoIcms")
class NfeDetalheImpostoIcmss extends Table {
	@override
	String get tableName => 'nfe_detalhe_imposto_icms';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	TextColumn get origemMercadoria => text().named('origem_mercadoria').withLength(min: 0, max: 1).nullable()();
	TextColumn get cstIcms => text().named('cst_icms').withLength(min: 0, max: 2).nullable()();
	TextColumn get csosn => text().named('csosn').withLength(min: 0, max: 3).nullable()();
	TextColumn get modalidadeBcIcms => text().named('modalidade_bc_icms').withLength(min: 0, max: 1).nullable()();
	RealColumn get percentualReducaoBcIcms => real().named('percentual_reducao_bc_icms').nullable()();
	RealColumn get valorBcIcms => real().named('valor_bc_icms').nullable()();
	RealColumn get aliquotaIcms => real().named('aliquota_icms').nullable()();
	RealColumn get valorIcmsOperacao => real().named('valor_icms_operacao').nullable()();
	RealColumn get percentualDiferimento => real().named('percentual_diferimento').nullable()();
	RealColumn get valorIcmsDiferido => real().named('valor_icms_diferido').nullable()();
	RealColumn get valorIcms => real().named('valor_icms').nullable()();
	RealColumn get baseCalculoFcp => real().named('base_calculo_fcp').nullable()();
	RealColumn get percentualFcp => real().named('percentual_fcp').nullable()();
	RealColumn get valorFcp => real().named('valor_fcp').nullable()();
	TextColumn get modalidadeBcIcmsSt => text().named('modalidade_bc_icms_st').withLength(min: 0, max: 1).nullable()();
	RealColumn get percentualMvaIcmsSt => real().named('percentual_mva_icms_st').nullable()();
	RealColumn get percentualReducaoBcIcmsSt => real().named('percentual_reducao_bc_icms_st').nullable()();
	RealColumn get valorBaseCalculoIcmsSt => real().named('valor_base_calculo_icms_st').nullable()();
	RealColumn get aliquotaIcmsSt => real().named('aliquota_icms_st').nullable()();
	RealColumn get valorIcmsSt => real().named('valor_icms_st').nullable()();
	RealColumn get baseCalculoFcpSt => real().named('base_calculo_fcp_st').nullable()();
	RealColumn get percentualFcpSt => real().named('percentual_fcp_st').nullable()();
	RealColumn get valorFcpSt => real().named('valor_fcp_st').nullable()();
	TextColumn get ufSt => text().named('uf_st').withLength(min: 0, max: 2).nullable()();
	RealColumn get percentualBcOperacaoPropria => real().named('percentual_bc_operacao_propria').nullable()();
	RealColumn get valorBcIcmsStRetido => real().named('valor_bc_icms_st_retido').nullable()();
	RealColumn get aliquotaSuportadaConsumidor => real().named('aliquota_suportada_consumidor').nullable()();
	RealColumn get valorIcmsSubstituto => real().named('valor_icms_substituto').nullable()();
	RealColumn get valorIcmsStRetido => real().named('valor_icms_st_retido').nullable()();
	RealColumn get baseCalculoFcpStRetido => real().named('base_calculo_fcp_st_retido').nullable()();
	RealColumn get percentualFcpStRetido => real().named('percentual_fcp_st_retido').nullable()();
	RealColumn get valorFcpStRetido => real().named('valor_fcp_st_retido').nullable()();
	TextColumn get motivoDesoneracaoIcms => text().named('motivo_desoneracao_icms').withLength(min: 0, max: 2).nullable()();
	RealColumn get valorIcmsDesonerado => real().named('valor_icms_desonerado').nullable()();
	RealColumn get aliquotaCreditoIcmsSn => real().named('aliquota_credito_icms_sn').nullable()();
	RealColumn get valorCreditoIcmsSn => real().named('valor_credito_icms_sn').nullable()();
	RealColumn get valorBcIcmsStDestino => real().named('valor_bc_icms_st_destino').nullable()();
	RealColumn get valorIcmsStDestino => real().named('valor_icms_st_destino').nullable()();
	RealColumn get percentualReducaoBcEfetivo => real().named('percentual_reducao_bc_efetivo').nullable()();
	RealColumn get valorBcEfetivo => real().named('valor_bc_efetivo').nullable()();
	RealColumn get aliquotaIcmsEfetivo => real().named('aliquota_icms_efetivo').nullable()();
	RealColumn get valorIcmsEfetivo => real().named('valor_icms_efetivo').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetalheImpostoIcmsGrouped {
	NfeDetalheImpostoIcms? nfeDetalheImpostoIcms; 

  NfeDetalheImpostoIcmsGrouped({
		this.nfeDetalheImpostoIcms, 

  });
}
