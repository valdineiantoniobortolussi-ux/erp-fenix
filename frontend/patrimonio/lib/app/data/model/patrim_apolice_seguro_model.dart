import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class PatrimApoliceSeguroModel {
	int? id;
	int? idPatrimBem;
	int? idSeguradora;
	String? numero;
	DateTime? dataContratacao;
	DateTime? dataVencimento;
	double? valorPremio;
	double? valorSegurado;
	String? observacao;
	String? imagem;
	SeguradoraModel? seguradoraModel;

	PatrimApoliceSeguroModel({
		this.id,
		this.idPatrimBem,
		this.idSeguradora,
		this.numero,
		this.dataContratacao,
		this.dataVencimento,
		this.valorPremio,
		this.valorSegurado,
		this.observacao,
		this.imagem,
		this.seguradoraModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'data_contratacao',
		'data_vencimento',
		'valor_premio',
		'valor_segurado',
		'observacao',
		'imagem',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Data Contratacao',
		'Data Vencimento',
		'Valor Premio',
		'Valor Segurado',
		'Observacao',
		'Imagem',
	];

	PatrimApoliceSeguroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPatrimBem = jsonData['idPatrimBem'];
		idSeguradora = jsonData['idSeguradora'];
		numero = jsonData['numero'];
		dataContratacao = jsonData['dataContratacao'] != null ? DateTime.tryParse(jsonData['dataContratacao']) : null;
		dataVencimento = jsonData['dataVencimento'] != null ? DateTime.tryParse(jsonData['dataVencimento']) : null;
		valorPremio = jsonData['valorPremio']?.toDouble();
		valorSegurado = jsonData['valorSegurado']?.toDouble();
		observacao = jsonData['observacao'];
		imagem = jsonData['imagem'];
		seguradoraModel = jsonData['seguradoraModel'] == null ? SeguradoraModel() : SeguradoraModel.fromJson(jsonData['seguradoraModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPatrimBem'] = idPatrimBem != 0 ? idPatrimBem : null;
		jsonData['idSeguradora'] = idSeguradora != 0 ? idSeguradora : null;
		jsonData['numero'] = numero;
		jsonData['dataContratacao'] = dataContratacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataContratacao!) : null;
		jsonData['dataVencimento'] = dataVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataVencimento!) : null;
		jsonData['valorPremio'] = valorPremio;
		jsonData['valorSegurado'] = valorSegurado;
		jsonData['observacao'] = observacao;
		jsonData['imagem'] = imagem;
		jsonData['seguradoraModel'] = seguradoraModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPatrimBem = plutoRow.cells['idPatrimBem']?.value;
		idSeguradora = plutoRow.cells['idSeguradora']?.value;
		numero = plutoRow.cells['numero']?.value;
		dataContratacao = Util.stringToDate(plutoRow.cells['dataContratacao']?.value);
		dataVencimento = Util.stringToDate(plutoRow.cells['dataVencimento']?.value);
		valorPremio = plutoRow.cells['valorPremio']?.value?.toDouble();
		valorSegurado = plutoRow.cells['valorSegurado']?.value?.toDouble();
		observacao = plutoRow.cells['observacao']?.value;
		imagem = plutoRow.cells['imagem']?.value;
		seguradoraModel = SeguradoraModel();
		seguradoraModel?.nome = plutoRow.cells['seguradoraModel']?.value;
	}	

	PatrimApoliceSeguroModel clone() {
		return PatrimApoliceSeguroModel(
			id: id,
			idPatrimBem: idPatrimBem,
			idSeguradora: idSeguradora,
			numero: numero,
			dataContratacao: dataContratacao,
			dataVencimento: dataVencimento,
			valorPremio: valorPremio,
			valorSegurado: valorSegurado,
			observacao: observacao,
			imagem: imagem,
		);			
	}

	
}