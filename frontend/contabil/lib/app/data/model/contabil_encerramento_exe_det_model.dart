import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/data/model/model_imports.dart';

class ContabilEncerramentoExeDetModel {
	int? id;
	int? idContabilEncerramentoExe;
	int? idContabilConta;
	double? saldoAnterior;
	double? valorDebito;
	double? valorCredito;
	double? saldo;
	ContabilContaModel? contabilContaModel;

	ContabilEncerramentoExeDetModel({
		this.id,
		this.idContabilEncerramentoExe,
		this.idContabilConta,
		this.saldoAnterior,
		this.valorDebito,
		this.valorCredito,
		this.saldo,
		this.contabilContaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'saldo_anterior',
		'valor_debito',
		'valor_credito',
		'saldo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Saldo Anterior',
		'Valor Debito',
		'Valor Credito',
		'Saldo',
	];

	ContabilEncerramentoExeDetModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContabilEncerramentoExe = jsonData['idContabilEncerramentoExe'];
		idContabilConta = jsonData['idContabilConta'];
		saldoAnterior = jsonData['saldoAnterior']?.toDouble();
		valorDebito = jsonData['valorDebito']?.toDouble();
		valorCredito = jsonData['valorCredito']?.toDouble();
		saldo = jsonData['saldo']?.toDouble();
		contabilContaModel = jsonData['contabilContaModel'] == null ? ContabilContaModel() : ContabilContaModel.fromJson(jsonData['contabilContaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContabilEncerramentoExe'] = idContabilEncerramentoExe != 0 ? idContabilEncerramentoExe : null;
		jsonData['idContabilConta'] = idContabilConta != 0 ? idContabilConta : null;
		jsonData['saldoAnterior'] = saldoAnterior;
		jsonData['valorDebito'] = valorDebito;
		jsonData['valorCredito'] = valorCredito;
		jsonData['saldo'] = saldo;
		jsonData['contabilContaModel'] = contabilContaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContabilEncerramentoExe = plutoRow.cells['idContabilEncerramentoExe']?.value;
		idContabilConta = plutoRow.cells['idContabilConta']?.value;
		saldoAnterior = plutoRow.cells['saldoAnterior']?.value?.toDouble();
		valorDebito = plutoRow.cells['valorDebito']?.value?.toDouble();
		valorCredito = plutoRow.cells['valorCredito']?.value?.toDouble();
		saldo = plutoRow.cells['saldo']?.value?.toDouble();
		contabilContaModel = ContabilContaModel();
		contabilContaModel?.descricao = plutoRow.cells['contabilContaModel']?.value;
	}	

	ContabilEncerramentoExeDetModel clone() {
		return ContabilEncerramentoExeDetModel(
			id: id,
			idContabilEncerramentoExe: idContabilEncerramentoExe,
			idContabilConta: idContabilConta,
			saldoAnterior: saldoAnterior,
			valorDebito: valorDebito,
			valorCredito: valorCredito,
			saldo: saldo,
		);			
	}

	
}