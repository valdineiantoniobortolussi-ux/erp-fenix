import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeDetalheImpostoIcmsModel {
	int? id;
	int? idNfeDetalhe;
	String? origemMercadoria;
	String? cstIcms;
	String? csosn;
	String? modalidadeBcIcms;
	double? percentualReducaoBcIcms;
	double? valorBcIcms;
	double? aliquotaIcms;
	double? valorIcmsOperacao;
	double? percentualDiferimento;
	double? valorIcmsDiferido;
	double? valorIcms;
	double? baseCalculoFcp;
	double? percentualFcp;
	double? valorFcp;
	String? modalidadeBcIcmsSt;
	double? percentualMvaIcmsSt;
	double? percentualReducaoBcIcmsSt;
	double? valorBaseCalculoIcmsSt;
	double? aliquotaIcmsSt;
	double? valorIcmsSt;
	double? baseCalculoFcpSt;
	double? percentualFcpSt;
	double? valorFcpSt;
	String? ufSt;
	double? percentualBcOperacaoPropria;
	double? valorBcIcmsStRetido;
	double? aliquotaSuportadaConsumidor;
	double? valorIcmsSubstituto;
	double? valorIcmsStRetido;
	double? baseCalculoFcpStRetido;
	double? percentualFcpStRetido;
	double? valorFcpStRetido;
	String? motivoDesoneracaoIcms;
	double? valorIcmsDesonerado;
	double? aliquotaCreditoIcmsSn;
	double? valorCreditoIcmsSn;
	double? valorBcIcmsStDestino;
	double? valorIcmsStDestino;
	double? percentualReducaoBcEfetivo;
	double? valorBcEfetivo;
	double? aliquotaIcmsEfetivo;
	double? valorIcmsEfetivo;

	NfeDetalheImpostoIcmsModel({
		this.id,
		this.idNfeDetalhe,
		this.origemMercadoria,
		this.cstIcms,
		this.csosn,
		this.modalidadeBcIcms,
		this.percentualReducaoBcIcms,
		this.valorBcIcms,
		this.aliquotaIcms,
		this.valorIcmsOperacao,
		this.percentualDiferimento,
		this.valorIcmsDiferido,
		this.valorIcms,
		this.baseCalculoFcp,
		this.percentualFcp,
		this.valorFcp,
		this.modalidadeBcIcmsSt,
		this.percentualMvaIcmsSt,
		this.percentualReducaoBcIcmsSt,
		this.valorBaseCalculoIcmsSt,
		this.aliquotaIcmsSt,
		this.valorIcmsSt,
		this.baseCalculoFcpSt,
		this.percentualFcpSt,
		this.valorFcpSt,
		this.ufSt,
		this.percentualBcOperacaoPropria,
		this.valorBcIcmsStRetido,
		this.aliquotaSuportadaConsumidor,
		this.valorIcmsSubstituto,
		this.valorIcmsStRetido,
		this.baseCalculoFcpStRetido,
		this.percentualFcpStRetido,
		this.valorFcpStRetido,
		this.motivoDesoneracaoIcms,
		this.valorIcmsDesonerado,
		this.aliquotaCreditoIcmsSn,
		this.valorCreditoIcmsSn,
		this.valorBcIcmsStDestino,
		this.valorIcmsStDestino,
		this.percentualReducaoBcEfetivo,
		this.valorBcEfetivo,
		this.aliquotaIcmsEfetivo,
		this.valorIcmsEfetivo,
	});

	static List<String> dbColumns = <String>[
		'id',
		'origem_mercadoria',
		'cst_icms',
		'csosn',
		'modalidade_bc_icms',
		'percentual_reducao_bc_icms',
		'valor_bc_icms',
		'aliquota_icms',
		'valor_icms_operacao',
		'percentual_diferimento',
		'valor_icms_diferido',
		'valor_icms',
		'base_calculo_fcp',
		'percentual_fcp',
		'valor_fcp',
		'modalidade_bc_icms_st',
		'percentual_mva_icms_st',
		'percentual_reducao_bc_icms_st',
		'valor_base_calculo_icms_st',
		'aliquota_icms_st',
		'valor_icms_st',
		'base_calculo_fcp_st',
		'percentual_fcp_st',
		'valor_fcp_st',
		'uf_st',
		'percentual_bc_operacao_propria',
		'valor_bc_icms_st_retido',
		'aliquota_suportada_consumidor',
		'valor_icms_substituto',
		'valor_icms_st_retido',
		'base_calculo_fcp_st_retido',
		'percentual_fcp_st_retido',
		'valor_fcp_st_retido',
		'motivo_desoneracao_icms',
		'valor_icms_desonerado',
		'aliquota_credito_icms_sn',
		'valor_credito_icms_sn',
		'valor_bc_icms_st_destino',
		'valor_icms_st_destino',
		'percentual_reducao_bc_efetivo',
		'valor_bc_efetivo',
		'aliquota_icms_efetivo',
		'valor_icms_efetivo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Origem Mercadoria',
		'Cst Icms',
		'Csosn',
		'Modalidade Bc Icms',
		'Percentual Reducao Bc Icms',
		'Valor Bc Icms',
		'Aliquota Icms',
		'Valor Icms Operacao',
		'Percentual Diferimento',
		'Valor Icms Diferido',
		'Valor Icms',
		'Base Calculo Fcp',
		'Percentual Fcp',
		'Valor Fcp',
		'Modalidade Bc Icms St',
		'Percentual Mva Icms St',
		'Percentual Reducao Bc Icms St',
		'Valor Base Calculo Icms St',
		'Aliquota Icms St',
		'Valor Icms St',
		'Base Calculo Fcp St',
		'Percentual Fcp St',
		'Valor Fcp St',
		'Uf St',
		'Percentual Bc Operacao Propria',
		'Valor Bc Icms St Retido',
		'Aliquota Suportada Consumidor',
		'Valor Icms Substituto',
		'Valor Icms St Retido',
		'Base Calculo Fcp St Retido',
		'Percentual Fcp St Retido',
		'Valor Fcp St Retido',
		'Motivo Desoneracao Icms',
		'Valor Icms Desonerado',
		'Aliquota Credito Icms Sn',
		'Valor Credito Icms Sn',
		'Valor Bc Icms St Destino',
		'Valor Icms St Destino',
		'Percentual Reducao Bc Efetivo',
		'Valor Bc Efetivo',
		'Aliquota Icms Efetivo',
		'Valor Icms Efetivo',
	];

	NfeDetalheImpostoIcmsModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		origemMercadoria = NfeDetalheImpostoIcmsDomain.getOrigemMercadoria(jsonData['origemMercadoria']);
		cstIcms = NfeDetalheImpostoIcmsDomain.getCstIcms(jsonData['cstIcms']);
		csosn = NfeDetalheImpostoIcmsDomain.getCsosn(jsonData['csosn']);
		modalidadeBcIcms = NfeDetalheImpostoIcmsDomain.getModalidadeBcIcms(jsonData['modalidadeBcIcms']);
		percentualReducaoBcIcms = jsonData['percentualReducaoBcIcms']?.toDouble();
		valorBcIcms = jsonData['valorBcIcms']?.toDouble();
		aliquotaIcms = jsonData['aliquotaIcms']?.toDouble();
		valorIcmsOperacao = jsonData['valorIcmsOperacao']?.toDouble();
		percentualDiferimento = jsonData['percentualDiferimento']?.toDouble();
		valorIcmsDiferido = jsonData['valorIcmsDiferido']?.toDouble();
		valorIcms = jsonData['valorIcms']?.toDouble();
		baseCalculoFcp = jsonData['baseCalculoFcp']?.toDouble();
		percentualFcp = jsonData['percentualFcp']?.toDouble();
		valorFcp = jsonData['valorFcp']?.toDouble();
		modalidadeBcIcmsSt = NfeDetalheImpostoIcmsDomain.getModalidadeBcIcmsSt(jsonData['modalidadeBcIcmsSt']);
		percentualMvaIcmsSt = jsonData['percentualMvaIcmsSt']?.toDouble();
		percentualReducaoBcIcmsSt = jsonData['percentualReducaoBcIcmsSt']?.toDouble();
		valorBaseCalculoIcmsSt = jsonData['valorBaseCalculoIcmsSt']?.toDouble();
		aliquotaIcmsSt = jsonData['aliquotaIcmsSt']?.toDouble();
		valorIcmsSt = jsonData['valorIcmsSt']?.toDouble();
		baseCalculoFcpSt = jsonData['baseCalculoFcpSt']?.toDouble();
		percentualFcpSt = jsonData['percentualFcpSt']?.toDouble();
		valorFcpSt = jsonData['valorFcpSt']?.toDouble();
		ufSt = NfeDetalheImpostoIcmsDomain.getUfSt(jsonData['ufSt']);
		percentualBcOperacaoPropria = jsonData['percentualBcOperacaoPropria']?.toDouble();
		valorBcIcmsStRetido = jsonData['valorBcIcmsStRetido']?.toDouble();
		aliquotaSuportadaConsumidor = jsonData['aliquotaSuportadaConsumidor']?.toDouble();
		valorIcmsSubstituto = jsonData['valorIcmsSubstituto']?.toDouble();
		valorIcmsStRetido = jsonData['valorIcmsStRetido']?.toDouble();
		baseCalculoFcpStRetido = jsonData['baseCalculoFcpStRetido']?.toDouble();
		percentualFcpStRetido = jsonData['percentualFcpStRetido']?.toDouble();
		valorFcpStRetido = jsonData['valorFcpStRetido']?.toDouble();
		motivoDesoneracaoIcms = NfeDetalheImpostoIcmsDomain.getMotivoDesoneracaoIcms(jsonData['motivoDesoneracaoIcms']);
		valorIcmsDesonerado = jsonData['valorIcmsDesonerado']?.toDouble();
		aliquotaCreditoIcmsSn = jsonData['aliquotaCreditoIcmsSn']?.toDouble();
		valorCreditoIcmsSn = jsonData['valorCreditoIcmsSn']?.toDouble();
		valorBcIcmsStDestino = jsonData['valorBcIcmsStDestino']?.toDouble();
		valorIcmsStDestino = jsonData['valorIcmsStDestino']?.toDouble();
		percentualReducaoBcEfetivo = jsonData['percentualReducaoBcEfetivo']?.toDouble();
		valorBcEfetivo = jsonData['valorBcEfetivo']?.toDouble();
		aliquotaIcmsEfetivo = jsonData['aliquotaIcmsEfetivo']?.toDouble();
		valorIcmsEfetivo = jsonData['valorIcmsEfetivo']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['origemMercadoria'] = NfeDetalheImpostoIcmsDomain.setOrigemMercadoria(origemMercadoria);
		jsonData['cstIcms'] = NfeDetalheImpostoIcmsDomain.setCstIcms(cstIcms);
		jsonData['csosn'] = NfeDetalheImpostoIcmsDomain.setCsosn(csosn);
		jsonData['modalidadeBcIcms'] = NfeDetalheImpostoIcmsDomain.setModalidadeBcIcms(modalidadeBcIcms);
		jsonData['percentualReducaoBcIcms'] = percentualReducaoBcIcms;
		jsonData['valorBcIcms'] = valorBcIcms;
		jsonData['aliquotaIcms'] = aliquotaIcms;
		jsonData['valorIcmsOperacao'] = valorIcmsOperacao;
		jsonData['percentualDiferimento'] = percentualDiferimento;
		jsonData['valorIcmsDiferido'] = valorIcmsDiferido;
		jsonData['valorIcms'] = valorIcms;
		jsonData['baseCalculoFcp'] = baseCalculoFcp;
		jsonData['percentualFcp'] = percentualFcp;
		jsonData['valorFcp'] = valorFcp;
		jsonData['modalidadeBcIcmsSt'] = NfeDetalheImpostoIcmsDomain.setModalidadeBcIcmsSt(modalidadeBcIcmsSt);
		jsonData['percentualMvaIcmsSt'] = percentualMvaIcmsSt;
		jsonData['percentualReducaoBcIcmsSt'] = percentualReducaoBcIcmsSt;
		jsonData['valorBaseCalculoIcmsSt'] = valorBaseCalculoIcmsSt;
		jsonData['aliquotaIcmsSt'] = aliquotaIcmsSt;
		jsonData['valorIcmsSt'] = valorIcmsSt;
		jsonData['baseCalculoFcpSt'] = baseCalculoFcpSt;
		jsonData['percentualFcpSt'] = percentualFcpSt;
		jsonData['valorFcpSt'] = valorFcpSt;
		jsonData['ufSt'] = NfeDetalheImpostoIcmsDomain.setUfSt(ufSt);
		jsonData['percentualBcOperacaoPropria'] = percentualBcOperacaoPropria;
		jsonData['valorBcIcmsStRetido'] = valorBcIcmsStRetido;
		jsonData['aliquotaSuportadaConsumidor'] = aliquotaSuportadaConsumidor;
		jsonData['valorIcmsSubstituto'] = valorIcmsSubstituto;
		jsonData['valorIcmsStRetido'] = valorIcmsStRetido;
		jsonData['baseCalculoFcpStRetido'] = baseCalculoFcpStRetido;
		jsonData['percentualFcpStRetido'] = percentualFcpStRetido;
		jsonData['valorFcpStRetido'] = valorFcpStRetido;
		jsonData['motivoDesoneracaoIcms'] = NfeDetalheImpostoIcmsDomain.setMotivoDesoneracaoIcms(motivoDesoneracaoIcms);
		jsonData['valorIcmsDesonerado'] = valorIcmsDesonerado;
		jsonData['aliquotaCreditoIcmsSn'] = aliquotaCreditoIcmsSn;
		jsonData['valorCreditoIcmsSn'] = valorCreditoIcmsSn;
		jsonData['valorBcIcmsStDestino'] = valorBcIcmsStDestino;
		jsonData['valorIcmsStDestino'] = valorIcmsStDestino;
		jsonData['percentualReducaoBcEfetivo'] = percentualReducaoBcEfetivo;
		jsonData['valorBcEfetivo'] = valorBcEfetivo;
		jsonData['aliquotaIcmsEfetivo'] = aliquotaIcmsEfetivo;
		jsonData['valorIcmsEfetivo'] = valorIcmsEfetivo;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		origemMercadoria = plutoRow.cells['origemMercadoria']?.value != '' ? plutoRow.cells['origemMercadoria']?.value : 'AAA';
		cstIcms = plutoRow.cells['cstIcms']?.value != '' ? plutoRow.cells['cstIcms']?.value : 'AAA';
		csosn = plutoRow.cells['csosn']?.value != '' ? plutoRow.cells['csosn']?.value : 'AAA';
		modalidadeBcIcms = plutoRow.cells['modalidadeBcIcms']?.value != '' ? plutoRow.cells['modalidadeBcIcms']?.value : 'AAA';
		percentualReducaoBcIcms = plutoRow.cells['percentualReducaoBcIcms']?.value?.toDouble();
		valorBcIcms = plutoRow.cells['valorBcIcms']?.value?.toDouble();
		aliquotaIcms = plutoRow.cells['aliquotaIcms']?.value?.toDouble();
		valorIcmsOperacao = plutoRow.cells['valorIcmsOperacao']?.value?.toDouble();
		percentualDiferimento = plutoRow.cells['percentualDiferimento']?.value?.toDouble();
		valorIcmsDiferido = plutoRow.cells['valorIcmsDiferido']?.value?.toDouble();
		valorIcms = plutoRow.cells['valorIcms']?.value?.toDouble();
		baseCalculoFcp = plutoRow.cells['baseCalculoFcp']?.value?.toDouble();
		percentualFcp = plutoRow.cells['percentualFcp']?.value?.toDouble();
		valorFcp = plutoRow.cells['valorFcp']?.value?.toDouble();
		modalidadeBcIcmsSt = plutoRow.cells['modalidadeBcIcmsSt']?.value != '' ? plutoRow.cells['modalidadeBcIcmsSt']?.value : 'AAA';
		percentualMvaIcmsSt = plutoRow.cells['percentualMvaIcmsSt']?.value?.toDouble();
		percentualReducaoBcIcmsSt = plutoRow.cells['percentualReducaoBcIcmsSt']?.value?.toDouble();
		valorBaseCalculoIcmsSt = plutoRow.cells['valorBaseCalculoIcmsSt']?.value?.toDouble();
		aliquotaIcmsSt = plutoRow.cells['aliquotaIcmsSt']?.value?.toDouble();
		valorIcmsSt = plutoRow.cells['valorIcmsSt']?.value?.toDouble();
		baseCalculoFcpSt = plutoRow.cells['baseCalculoFcpSt']?.value?.toDouble();
		percentualFcpSt = plutoRow.cells['percentualFcpSt']?.value?.toDouble();
		valorFcpSt = plutoRow.cells['valorFcpSt']?.value?.toDouble();
		ufSt = plutoRow.cells['ufSt']?.value != '' ? plutoRow.cells['ufSt']?.value : 'AC';
		percentualBcOperacaoPropria = plutoRow.cells['percentualBcOperacaoPropria']?.value?.toDouble();
		valorBcIcmsStRetido = plutoRow.cells['valorBcIcmsStRetido']?.value?.toDouble();
		aliquotaSuportadaConsumidor = plutoRow.cells['aliquotaSuportadaConsumidor']?.value?.toDouble();
		valorIcmsSubstituto = plutoRow.cells['valorIcmsSubstituto']?.value?.toDouble();
		valorIcmsStRetido = plutoRow.cells['valorIcmsStRetido']?.value?.toDouble();
		baseCalculoFcpStRetido = plutoRow.cells['baseCalculoFcpStRetido']?.value?.toDouble();
		percentualFcpStRetido = plutoRow.cells['percentualFcpStRetido']?.value?.toDouble();
		valorFcpStRetido = plutoRow.cells['valorFcpStRetido']?.value?.toDouble();
		motivoDesoneracaoIcms = plutoRow.cells['motivoDesoneracaoIcms']?.value != '' ? plutoRow.cells['motivoDesoneracaoIcms']?.value : 'AAA';
		valorIcmsDesonerado = plutoRow.cells['valorIcmsDesonerado']?.value?.toDouble();
		aliquotaCreditoIcmsSn = plutoRow.cells['aliquotaCreditoIcmsSn']?.value?.toDouble();
		valorCreditoIcmsSn = plutoRow.cells['valorCreditoIcmsSn']?.value?.toDouble();
		valorBcIcmsStDestino = plutoRow.cells['valorBcIcmsStDestino']?.value?.toDouble();
		valorIcmsStDestino = plutoRow.cells['valorIcmsStDestino']?.value?.toDouble();
		percentualReducaoBcEfetivo = plutoRow.cells['percentualReducaoBcEfetivo']?.value?.toDouble();
		valorBcEfetivo = plutoRow.cells['valorBcEfetivo']?.value?.toDouble();
		aliquotaIcmsEfetivo = plutoRow.cells['aliquotaIcmsEfetivo']?.value?.toDouble();
		valorIcmsEfetivo = plutoRow.cells['valorIcmsEfetivo']?.value?.toDouble();
	}	

	NfeDetalheImpostoIcmsModel clone() {
		return NfeDetalheImpostoIcmsModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			origemMercadoria: origemMercadoria,
			cstIcms: cstIcms,
			csosn: csosn,
			modalidadeBcIcms: modalidadeBcIcms,
			percentualReducaoBcIcms: percentualReducaoBcIcms,
			valorBcIcms: valorBcIcms,
			aliquotaIcms: aliquotaIcms,
			valorIcmsOperacao: valorIcmsOperacao,
			percentualDiferimento: percentualDiferimento,
			valorIcmsDiferido: valorIcmsDiferido,
			valorIcms: valorIcms,
			baseCalculoFcp: baseCalculoFcp,
			percentualFcp: percentualFcp,
			valorFcp: valorFcp,
			modalidadeBcIcmsSt: modalidadeBcIcmsSt,
			percentualMvaIcmsSt: percentualMvaIcmsSt,
			percentualReducaoBcIcmsSt: percentualReducaoBcIcmsSt,
			valorBaseCalculoIcmsSt: valorBaseCalculoIcmsSt,
			aliquotaIcmsSt: aliquotaIcmsSt,
			valorIcmsSt: valorIcmsSt,
			baseCalculoFcpSt: baseCalculoFcpSt,
			percentualFcpSt: percentualFcpSt,
			valorFcpSt: valorFcpSt,
			ufSt: ufSt,
			percentualBcOperacaoPropria: percentualBcOperacaoPropria,
			valorBcIcmsStRetido: valorBcIcmsStRetido,
			aliquotaSuportadaConsumidor: aliquotaSuportadaConsumidor,
			valorIcmsSubstituto: valorIcmsSubstituto,
			valorIcmsStRetido: valorIcmsStRetido,
			baseCalculoFcpStRetido: baseCalculoFcpStRetido,
			percentualFcpStRetido: percentualFcpStRetido,
			valorFcpStRetido: valorFcpStRetido,
			motivoDesoneracaoIcms: motivoDesoneracaoIcms,
			valorIcmsDesonerado: valorIcmsDesonerado,
			aliquotaCreditoIcmsSn: aliquotaCreditoIcmsSn,
			valorCreditoIcmsSn: valorCreditoIcmsSn,
			valorBcIcmsStDestino: valorBcIcmsStDestino,
			valorIcmsStDestino: valorIcmsStDestino,
			percentualReducaoBcEfetivo: percentualReducaoBcEfetivo,
			valorBcEfetivo: valorBcEfetivo,
			aliquotaIcmsEfetivo: aliquotaIcmsEfetivo,
			valorIcmsEfetivo: valorIcmsEfetivo,
		);			
	}

	
}