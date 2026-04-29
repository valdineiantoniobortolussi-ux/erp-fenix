import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contratos/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class ContratoHistoricoReajusteModel {
	int? id;
	int? idContrato;
	double? indice;
	double? valorAnterior;
	double? valorAtual;
	DateTime? dataReajuste;
	String? observacao;

	ContratoHistoricoReajusteModel({
		this.id,
		this.idContrato,
		this.indice,
		this.valorAnterior,
		this.valorAtual,
		this.dataReajuste,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'indice',
		'valor_anterior',
		'valor_atual',
		'data_reajuste',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Indice',
		'Valor Anterior',
		'Valor Atual',
		'Data Reajuste',
		'Observacao',
	];

	ContratoHistoricoReajusteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContrato = jsonData['idContrato'];
		indice = jsonData['indice']?.toDouble();
		valorAnterior = jsonData['valorAnterior']?.toDouble();
		valorAtual = jsonData['valorAtual']?.toDouble();
		dataReajuste = jsonData['dataReajuste'] != null ? DateTime.tryParse(jsonData['dataReajuste']) : null;
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContrato'] = idContrato != 0 ? idContrato : null;
		jsonData['indice'] = indice;
		jsonData['valorAnterior'] = valorAnterior;
		jsonData['valorAtual'] = valorAtual;
		jsonData['dataReajuste'] = dataReajuste != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataReajuste!) : null;
		jsonData['observacao'] = observacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContrato = plutoRow.cells['idContrato']?.value;
		indice = plutoRow.cells['indice']?.value?.toDouble();
		valorAnterior = plutoRow.cells['valorAnterior']?.value?.toDouble();
		valorAtual = plutoRow.cells['valorAtual']?.value?.toDouble();
		dataReajuste = Util.stringToDate(plutoRow.cells['dataReajuste']?.value);
		observacao = plutoRow.cells['observacao']?.value;
	}	

	ContratoHistoricoReajusteModel clone() {
		return ContratoHistoricoReajusteModel(
			id: id,
			idContrato: idContrato,
			indice: indice,
			valorAnterior: valorAnterior,
			valorAtual: valorAtual,
			dataReajuste: dataReajuste,
			observacao: observacao,
		);			
	}

	
}