import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:fiscal/app/infra/infra_imports.dart';

class FiscalApuracaoIcmsModel {
	int? id;
	String? competencia;
	double? valorTotalDebito;
	double? valorAjusteDebito;
	double? valorTotalAjusteDebito;
	double? valorEstornoCredito;
	double? valorTotalCredito;
	double? valorAjusteCredito;
	double? valorTotalAjusteCredito;
	double? valorEstornoDebito;
	double? valorSaldoCredorAnterior;
	double? valorSaldoApurado;
	double? valorTotalDeducao;
	double? valorIcmsRecolher;
	double? valorSaldoCredorTransp;
	double? valorDebitoEspecial;

	FiscalApuracaoIcmsModel({
		this.id,
		this.competencia,
		this.valorTotalDebito,
		this.valorAjusteDebito,
		this.valorTotalAjusteDebito,
		this.valorEstornoCredito,
		this.valorTotalCredito,
		this.valorAjusteCredito,
		this.valorTotalAjusteCredito,
		this.valorEstornoDebito,
		this.valorSaldoCredorAnterior,
		this.valorSaldoApurado,
		this.valorTotalDeducao,
		this.valorIcmsRecolher,
		this.valorSaldoCredorTransp,
		this.valorDebitoEspecial,
	});

	static List<String> dbColumns = <String>[
		'id',
		'competencia',
		'valor_total_debito',
		'valor_ajuste_debito',
		'valor_total_ajuste_debito',
		'valor_estorno_credito',
		'valor_total_credito',
		'valor_ajuste_credito',
		'valor_total_ajuste_credito',
		'valor_estorno_debito',
		'valor_saldo_credor_anterior',
		'valor_saldo_apurado',
		'valor_total_deducao',
		'valor_icms_recolher',
		'valor_saldo_credor_transp',
		'valor_debito_especial',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Competencia',
		'Valor Total Debito',
		'Valor Ajuste Debito',
		'Valor Total Ajuste Debito',
		'Valor Estorno Credito',
		'Valor Total Credito',
		'Valor Ajuste Credito',
		'Valor Total Ajuste Credito',
		'Valor Estorno Debito',
		'Valor Saldo Credor Anterior',
		'Valor Saldo Apurado',
		'Valor Total Deducao',
		'Valor Icms Recolher',
		'Valor Saldo Credor Transp',
		'Valor Debito Especial',
	];

	FiscalApuracaoIcmsModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		competencia = jsonData['competencia'];
		valorTotalDebito = jsonData['valorTotalDebito']?.toDouble();
		valorAjusteDebito = jsonData['valorAjusteDebito']?.toDouble();
		valorTotalAjusteDebito = jsonData['valorTotalAjusteDebito']?.toDouble();
		valorEstornoCredito = jsonData['valorEstornoCredito']?.toDouble();
		valorTotalCredito = jsonData['valorTotalCredito']?.toDouble();
		valorAjusteCredito = jsonData['valorAjusteCredito']?.toDouble();
		valorTotalAjusteCredito = jsonData['valorTotalAjusteCredito']?.toDouble();
		valorEstornoDebito = jsonData['valorEstornoDebito']?.toDouble();
		valorSaldoCredorAnterior = jsonData['valorSaldoCredorAnterior']?.toDouble();
		valorSaldoApurado = jsonData['valorSaldoApurado']?.toDouble();
		valorTotalDeducao = jsonData['valorTotalDeducao']?.toDouble();
		valorIcmsRecolher = jsonData['valorIcmsRecolher']?.toDouble();
		valorSaldoCredorTransp = jsonData['valorSaldoCredorTransp']?.toDouble();
		valorDebitoEspecial = jsonData['valorDebitoEspecial']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['competencia'] = Util.removeMask(competencia);
		jsonData['valorTotalDebito'] = valorTotalDebito;
		jsonData['valorAjusteDebito'] = valorAjusteDebito;
		jsonData['valorTotalAjusteDebito'] = valorTotalAjusteDebito;
		jsonData['valorEstornoCredito'] = valorEstornoCredito;
		jsonData['valorTotalCredito'] = valorTotalCredito;
		jsonData['valorAjusteCredito'] = valorAjusteCredito;
		jsonData['valorTotalAjusteCredito'] = valorTotalAjusteCredito;
		jsonData['valorEstornoDebito'] = valorEstornoDebito;
		jsonData['valorSaldoCredorAnterior'] = valorSaldoCredorAnterior;
		jsonData['valorSaldoApurado'] = valorSaldoApurado;
		jsonData['valorTotalDeducao'] = valorTotalDeducao;
		jsonData['valorIcmsRecolher'] = valorIcmsRecolher;
		jsonData['valorSaldoCredorTransp'] = valorSaldoCredorTransp;
		jsonData['valorDebitoEspecial'] = valorDebitoEspecial;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		competencia = plutoRow.cells['competencia']?.value;
		valorTotalDebito = plutoRow.cells['valorTotalDebito']?.value?.toDouble();
		valorAjusteDebito = plutoRow.cells['valorAjusteDebito']?.value?.toDouble();
		valorTotalAjusteDebito = plutoRow.cells['valorTotalAjusteDebito']?.value?.toDouble();
		valorEstornoCredito = plutoRow.cells['valorEstornoCredito']?.value?.toDouble();
		valorTotalCredito = plutoRow.cells['valorTotalCredito']?.value?.toDouble();
		valorAjusteCredito = plutoRow.cells['valorAjusteCredito']?.value?.toDouble();
		valorTotalAjusteCredito = plutoRow.cells['valorTotalAjusteCredito']?.value?.toDouble();
		valorEstornoDebito = plutoRow.cells['valorEstornoDebito']?.value?.toDouble();
		valorSaldoCredorAnterior = plutoRow.cells['valorSaldoCredorAnterior']?.value?.toDouble();
		valorSaldoApurado = plutoRow.cells['valorSaldoApurado']?.value?.toDouble();
		valorTotalDeducao = plutoRow.cells['valorTotalDeducao']?.value?.toDouble();
		valorIcmsRecolher = plutoRow.cells['valorIcmsRecolher']?.value?.toDouble();
		valorSaldoCredorTransp = plutoRow.cells['valorSaldoCredorTransp']?.value?.toDouble();
		valorDebitoEspecial = plutoRow.cells['valorDebitoEspecial']?.value?.toDouble();
	}	

	FiscalApuracaoIcmsModel clone() {
		return FiscalApuracaoIcmsModel(
			id: id,
			competencia: competencia,
			valorTotalDebito: valorTotalDebito,
			valorAjusteDebito: valorAjusteDebito,
			valorTotalAjusteDebito: valorTotalAjusteDebito,
			valorEstornoCredito: valorEstornoCredito,
			valorTotalCredito: valorTotalCredito,
			valorAjusteCredito: valorAjusteCredito,
			valorTotalAjusteCredito: valorTotalAjusteCredito,
			valorEstornoDebito: valorEstornoDebito,
			valorSaldoCredorAnterior: valorSaldoCredorAnterior,
			valorSaldoApurado: valorSaldoApurado,
			valorTotalDeducao: valorTotalDeducao,
			valorIcmsRecolher: valorIcmsRecolher,
			valorSaldoCredorTransp: valorSaldoCredorTransp,
			valorDebitoEspecial: valorDebitoEspecial,
		);			
	}

	
}