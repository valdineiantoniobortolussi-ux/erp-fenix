import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class ContabilLancamentoPadraoModel {
	int? id;
	String? descricao;
	String? historico;
	int? idContaDebito;
	int? idContaCredito;

	ContabilLancamentoPadraoModel({
		this.id,
		this.descricao,
		this.historico,
		this.idContaDebito,
		this.idContaCredito,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
		'historico',
		'id_conta_debito',
		'id_conta_credito',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
		'Historico',
		'Id Conta Debito',
		'Id Conta Credito',
	];

	ContabilLancamentoPadraoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		descricao = jsonData['descricao'];
		historico = jsonData['historico'];
		idContaDebito = jsonData['idContaDebito'];
		idContaCredito = jsonData['idContaCredito'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['descricao'] = descricao;
		jsonData['historico'] = historico;
		jsonData['idContaDebito'] = idContaDebito;
		jsonData['idContaCredito'] = idContaCredito;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		historico = plutoRow.cells['historico']?.value;
		idContaDebito = plutoRow.cells['idContaDebito']?.value;
		idContaCredito = plutoRow.cells['idContaCredito']?.value;
	}	

	ContabilLancamentoPadraoModel clone() {
		return ContabilLancamentoPadraoModel(
			id: id,
			descricao: descricao,
			historico: historico,
			idContaDebito: idContaDebito,
			idContaCredito: idContaCredito,
		);			
	}

	
}