import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class TransportadoraModel {
	int? id;
	int? idPessoa;
	DateTime? dataCadastro;
	String? observacao;

	TransportadoraModel({
		this.id,
		this.idPessoa,
		this.dataCadastro,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_cadastro',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Cadastro',
		'Observacao',
	];

	TransportadoraModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa != 0 ? idPessoa : null;
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
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		observacao = plutoRow.cells['observacao']?.value;
	}	

	TransportadoraModel clone() {
		return TransportadoraModel(
			id: id,
			idPessoa: idPessoa,
			dataCadastro: dataCadastro,
			observacao: observacao,
		);			
	}

	
}