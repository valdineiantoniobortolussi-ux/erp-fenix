import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class FornecedorModel {
	int? id;
	int? idPessoa;
	DateTime? desde;
	DateTime? dataCadastro;
	String? observacao;

	FornecedorModel({
		this.id,
		this.idPessoa,
		this.desde,
		this.dataCadastro,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'desde',
		'data_cadastro',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Desde',
		'Data Cadastro',
		'Observacao',
	];

	FornecedorModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		desde = jsonData['desde'] != null ? DateTime.tryParse(jsonData['desde']) : null;
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa != 0 ? idPessoa : null;
		jsonData['desde'] = desde != null ? DateFormat('yyyy-MM-ddT00:00:00').format(desde!) : null;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['observacao'] = observacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
		desde = Util.stringToDate(plutoRow.cells['desde']?.value);
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		observacao = plutoRow.cells['observacao']?.value;
	}	

	FornecedorModel clone() {
		return FornecedorModel(
			id: id,
			idPessoa: idPessoa,
			desde: desde,
			dataCadastro: dataCadastro,
			observacao: observacao,
		);			
	}

	
}