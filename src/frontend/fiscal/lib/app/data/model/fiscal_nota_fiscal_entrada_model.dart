import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalNotaFiscalEntradaModel {
	int? id;
	int? idNfeCabecalho;
	String? competencia;
	int? cfopEntrada;
	double? valorRateioFrete;
	double? valorCustoMedio;
	double? valorIcmsAntecipado;
	double? valorBcIcmsAntecipado;
	double? valorBcIcmsCreditado;
	double? valorBcPisCreditado;
	double? valorBcCofinsCreditado;
	double? valorBcIpiCreditado;
	String? cstCreditoIcms;
	String? cstCreditoPis;
	String? cstCreditoCofins;
	String? cstCreditoIpi;
	double? valorIcmsCreditado;
	double? valorPisCreditado;
	double? valorCofinsCreditado;
	double? valorIpiCreditado;
	int? qtdeParcelaCreditoPis;
	int? qtdeParcelaCreditoCofins;
	int? qtdeParcelaCreditoIcms;
	int? qtdeParcelaCreditoIpi;
	double? aliquotaCreditoIcms;
	double? aliquotaCreditoPis;
	double? aliquotaCreditoCofins;
	double? aliquotaCreditoIpi;
	NfeCabecalhoModel? nfeCabecalhoModel;

	FiscalNotaFiscalEntradaModel({
		this.id,
		this.idNfeCabecalho,
		this.competencia,
		this.cfopEntrada,
		this.valorRateioFrete,
		this.valorCustoMedio,
		this.valorIcmsAntecipado,
		this.valorBcIcmsAntecipado,
		this.valorBcIcmsCreditado,
		this.valorBcPisCreditado,
		this.valorBcCofinsCreditado,
		this.valorBcIpiCreditado,
		this.cstCreditoIcms,
		this.cstCreditoPis,
		this.cstCreditoCofins,
		this.cstCreditoIpi,
		this.valorIcmsCreditado,
		this.valorPisCreditado,
		this.valorCofinsCreditado,
		this.valorIpiCreditado,
		this.qtdeParcelaCreditoPis,
		this.qtdeParcelaCreditoCofins,
		this.qtdeParcelaCreditoIcms,
		this.qtdeParcelaCreditoIpi,
		this.aliquotaCreditoIcms,
		this.aliquotaCreditoPis,
		this.aliquotaCreditoCofins,
		this.aliquotaCreditoIpi,
		this.nfeCabecalhoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'competencia',
		'cfop_entrada',
		'valor_rateio_frete',
		'valor_custo_medio',
		'valor_icms_antecipado',
		'valor_bc_icms_antecipado',
		'valor_bc_icms_creditado',
		'valor_bc_pis_creditado',
		'valor_bc_cofins_creditado',
		'valor_bc_ipi_creditado',
		'cst_credito_icms',
		'cst_credito_pis',
		'cst_credito_cofins',
		'cst_credito_ipi',
		'valor_icms_creditado',
		'valor_pis_creditado',
		'valor_cofins_creditado',
		'valor_ipi_creditado',
		'qtde_parcela_credito_pis',
		'qtde_parcela_credito_cofins',
		'qtde_parcela_credito_icms',
		'qtde_parcela_credito_ipi',
		'aliquota_credito_icms',
		'aliquota_credito_pis',
		'aliquota_credito_cofins',
		'aliquota_credito_ipi',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Competencia',
		'Cfop Entrada',
		'Valor Rateio Frete',
		'Valor Custo Medio',
		'Valor Icms Antecipado',
		'Valor Bc Icms Antecipado',
		'Valor Bc Icms Creditado',
		'Valor Bc Pis Creditado',
		'Valor Bc Cofins Creditado',
		'Valor Bc Ipi Creditado',
		'Cst Credito Icms',
		'Cst Credito Pis',
		'Cst Credito Cofins',
		'Cst Credito Ipi',
		'Valor Icms Creditado',
		'Valor Pis Creditado',
		'Valor Cofins Creditado',
		'Valor Ipi Creditado',
		'Qtde Parcela Credito Pis',
		'Qtde Parcela Credito Cofins',
		'Qtde Parcela Credito Icms',
		'Qtde Parcela Credito Ipi',
		'Aliquota Credito Icms',
		'Aliquota Credito Pis',
		'Aliquota Credito Cofins',
		'Aliquota Credito Ipi',
	];

	FiscalNotaFiscalEntradaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		competencia = jsonData['competencia'];
		cfopEntrada = jsonData['cfopEntrada'];
		valorRateioFrete = jsonData['valorRateioFrete']?.toDouble();
		valorCustoMedio = jsonData['valorCustoMedio']?.toDouble();
		valorIcmsAntecipado = jsonData['valorIcmsAntecipado']?.toDouble();
		valorBcIcmsAntecipado = jsonData['valorBcIcmsAntecipado']?.toDouble();
		valorBcIcmsCreditado = jsonData['valorBcIcmsCreditado']?.toDouble();
		valorBcPisCreditado = jsonData['valorBcPisCreditado']?.toDouble();
		valorBcCofinsCreditado = jsonData['valorBcCofinsCreditado']?.toDouble();
		valorBcIpiCreditado = jsonData['valorBcIpiCreditado']?.toDouble();
		cstCreditoIcms = jsonData['cstCreditoIcms'];
		cstCreditoPis = jsonData['cstCreditoPis'];
		cstCreditoCofins = jsonData['cstCreditoCofins'];
		cstCreditoIpi = jsonData['cstCreditoIpi'];
		valorIcmsCreditado = jsonData['valorIcmsCreditado']?.toDouble();
		valorPisCreditado = jsonData['valorPisCreditado']?.toDouble();
		valorCofinsCreditado = jsonData['valorCofinsCreditado']?.toDouble();
		valorIpiCreditado = jsonData['valorIpiCreditado']?.toDouble();
		qtdeParcelaCreditoPis = jsonData['qtdeParcelaCreditoPis'];
		qtdeParcelaCreditoCofins = jsonData['qtdeParcelaCreditoCofins'];
		qtdeParcelaCreditoIcms = jsonData['qtdeParcelaCreditoIcms'];
		qtdeParcelaCreditoIpi = jsonData['qtdeParcelaCreditoIpi'];
		aliquotaCreditoIcms = jsonData['aliquotaCreditoIcms']?.toDouble();
		aliquotaCreditoPis = jsonData['aliquotaCreditoPis']?.toDouble();
		aliquotaCreditoCofins = jsonData['aliquotaCreditoCofins']?.toDouble();
		aliquotaCreditoIpi = jsonData['aliquotaCreditoIpi']?.toDouble();
		nfeCabecalhoModel = jsonData['nfeCabecalhoModel'] == null ? NfeCabecalhoModel() : NfeCabecalhoModel.fromJson(jsonData['nfeCabecalhoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['competencia'] = Util.removeMask(competencia);
		jsonData['cfopEntrada'] = cfopEntrada;
		jsonData['valorRateioFrete'] = valorRateioFrete;
		jsonData['valorCustoMedio'] = valorCustoMedio;
		jsonData['valorIcmsAntecipado'] = valorIcmsAntecipado;
		jsonData['valorBcIcmsAntecipado'] = valorBcIcmsAntecipado;
		jsonData['valorBcIcmsCreditado'] = valorBcIcmsCreditado;
		jsonData['valorBcPisCreditado'] = valorBcPisCreditado;
		jsonData['valorBcCofinsCreditado'] = valorBcCofinsCreditado;
		jsonData['valorBcIpiCreditado'] = valorBcIpiCreditado;
		jsonData['cstCreditoIcms'] = cstCreditoIcms;
		jsonData['cstCreditoPis'] = cstCreditoPis;
		jsonData['cstCreditoCofins'] = cstCreditoCofins;
		jsonData['cstCreditoIpi'] = cstCreditoIpi;
		jsonData['valorIcmsCreditado'] = valorIcmsCreditado;
		jsonData['valorPisCreditado'] = valorPisCreditado;
		jsonData['valorCofinsCreditado'] = valorCofinsCreditado;
		jsonData['valorIpiCreditado'] = valorIpiCreditado;
		jsonData['qtdeParcelaCreditoPis'] = qtdeParcelaCreditoPis;
		jsonData['qtdeParcelaCreditoCofins'] = qtdeParcelaCreditoCofins;
		jsonData['qtdeParcelaCreditoIcms'] = qtdeParcelaCreditoIcms;
		jsonData['qtdeParcelaCreditoIpi'] = qtdeParcelaCreditoIpi;
		jsonData['aliquotaCreditoIcms'] = aliquotaCreditoIcms;
		jsonData['aliquotaCreditoPis'] = aliquotaCreditoPis;
		jsonData['aliquotaCreditoCofins'] = aliquotaCreditoCofins;
		jsonData['aliquotaCreditoIpi'] = aliquotaCreditoIpi;
		jsonData['nfeCabecalhoModel'] = nfeCabecalhoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		competencia = plutoRow.cells['competencia']?.value;
		cfopEntrada = plutoRow.cells['cfopEntrada']?.value;
		valorRateioFrete = plutoRow.cells['valorRateioFrete']?.value?.toDouble();
		valorCustoMedio = plutoRow.cells['valorCustoMedio']?.value?.toDouble();
		valorIcmsAntecipado = plutoRow.cells['valorIcmsAntecipado']?.value?.toDouble();
		valorBcIcmsAntecipado = plutoRow.cells['valorBcIcmsAntecipado']?.value?.toDouble();
		valorBcIcmsCreditado = plutoRow.cells['valorBcIcmsCreditado']?.value?.toDouble();
		valorBcPisCreditado = plutoRow.cells['valorBcPisCreditado']?.value?.toDouble();
		valorBcCofinsCreditado = plutoRow.cells['valorBcCofinsCreditado']?.value?.toDouble();
		valorBcIpiCreditado = plutoRow.cells['valorBcIpiCreditado']?.value?.toDouble();
		cstCreditoIcms = plutoRow.cells['cstCreditoIcms']?.value;
		cstCreditoPis = plutoRow.cells['cstCreditoPis']?.value;
		cstCreditoCofins = plutoRow.cells['cstCreditoCofins']?.value;
		cstCreditoIpi = plutoRow.cells['cstCreditoIpi']?.value;
		valorIcmsCreditado = plutoRow.cells['valorIcmsCreditado']?.value?.toDouble();
		valorPisCreditado = plutoRow.cells['valorPisCreditado']?.value?.toDouble();
		valorCofinsCreditado = plutoRow.cells['valorCofinsCreditado']?.value?.toDouble();
		valorIpiCreditado = plutoRow.cells['valorIpiCreditado']?.value?.toDouble();
		qtdeParcelaCreditoPis = plutoRow.cells['qtdeParcelaCreditoPis']?.value;
		qtdeParcelaCreditoCofins = plutoRow.cells['qtdeParcelaCreditoCofins']?.value;
		qtdeParcelaCreditoIcms = plutoRow.cells['qtdeParcelaCreditoIcms']?.value;
		qtdeParcelaCreditoIpi = plutoRow.cells['qtdeParcelaCreditoIpi']?.value;
		aliquotaCreditoIcms = plutoRow.cells['aliquotaCreditoIcms']?.value?.toDouble();
		aliquotaCreditoPis = plutoRow.cells['aliquotaCreditoPis']?.value?.toDouble();
		aliquotaCreditoCofins = plutoRow.cells['aliquotaCreditoCofins']?.value?.toDouble();
		aliquotaCreditoIpi = plutoRow.cells['aliquotaCreditoIpi']?.value?.toDouble();
		nfeCabecalhoModel = NfeCabecalhoModel();
		nfeCabecalhoModel?.chave_acesso = plutoRow.cells['nfeCabecalhoModel']?.value;
	}	

	FiscalNotaFiscalEntradaModel clone() {
		return FiscalNotaFiscalEntradaModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			competencia: competencia,
			cfopEntrada: cfopEntrada,
			valorRateioFrete: valorRateioFrete,
			valorCustoMedio: valorCustoMedio,
			valorIcmsAntecipado: valorIcmsAntecipado,
			valorBcIcmsAntecipado: valorBcIcmsAntecipado,
			valorBcIcmsCreditado: valorBcIcmsCreditado,
			valorBcPisCreditado: valorBcPisCreditado,
			valorBcCofinsCreditado: valorBcCofinsCreditado,
			valorBcIpiCreditado: valorBcIpiCreditado,
			cstCreditoIcms: cstCreditoIcms,
			cstCreditoPis: cstCreditoPis,
			cstCreditoCofins: cstCreditoCofins,
			cstCreditoIpi: cstCreditoIpi,
			valorIcmsCreditado: valorIcmsCreditado,
			valorPisCreditado: valorPisCreditado,
			valorCofinsCreditado: valorCofinsCreditado,
			valorIpiCreditado: valorIpiCreditado,
			qtdeParcelaCreditoPis: qtdeParcelaCreditoPis,
			qtdeParcelaCreditoCofins: qtdeParcelaCreditoCofins,
			qtdeParcelaCreditoIcms: qtdeParcelaCreditoIcms,
			qtdeParcelaCreditoIpi: qtdeParcelaCreditoIpi,
			aliquotaCreditoIcms: aliquotaCreditoIcms,
			aliquotaCreditoPis: aliquotaCreditoPis,
			aliquotaCreditoCofins: aliquotaCreditoCofins,
			aliquotaCreditoIpi: aliquotaCreditoIpi,
		);			
	}

	
}