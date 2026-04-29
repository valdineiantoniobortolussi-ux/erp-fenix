import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class NfeDetalheImpostoIiModel {
	int? id;
	int? idNfeDetalhe;
	double? valorBcIi;
	double? valorDespesasAduaneiras;
	double? valorImpostoImportacao;
	double? valorIof;

	NfeDetalheImpostoIiModel({
		this.id,
		this.idNfeDetalhe,
		this.valorBcIi,
		this.valorDespesasAduaneiras,
		this.valorImpostoImportacao,
		this.valorIof,
	});

	static List<String> dbColumns = <String>[
		'id',
		'valor_bc_ii',
		'valor_despesas_aduaneiras',
		'valor_imposto_importacao',
		'valor_iof',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Valor Bc Ii',
		'Valor Despesas Aduaneiras',
		'Valor Imposto Importacao',
		'Valor Iof',
	];

	NfeDetalheImpostoIiModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		valorBcIi = jsonData['valorBcIi']?.toDouble();
		valorDespesasAduaneiras = jsonData['valorDespesasAduaneiras']?.toDouble();
		valorImpostoImportacao = jsonData['valorImpostoImportacao']?.toDouble();
		valorIof = jsonData['valorIof']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['valorBcIi'] = valorBcIi;
		jsonData['valorDespesasAduaneiras'] = valorDespesasAduaneiras;
		jsonData['valorImpostoImportacao'] = valorImpostoImportacao;
		jsonData['valorIof'] = valorIof;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		valorBcIi = plutoRow.cells['valorBcIi']?.value?.toDouble();
		valorDespesasAduaneiras = plutoRow.cells['valorDespesasAduaneiras']?.value?.toDouble();
		valorImpostoImportacao = plutoRow.cells['valorImpostoImportacao']?.value?.toDouble();
		valorIof = plutoRow.cells['valorIof']?.value?.toDouble();
	}	

	NfeDetalheImpostoIiModel clone() {
		return NfeDetalheImpostoIiModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			valorBcIi: valorBcIi,
			valorDespesasAduaneiras: valorDespesasAduaneiras,
			valorImpostoImportacao: valorImpostoImportacao,
			valorIof: valorIof,
		);			
	}

	
}