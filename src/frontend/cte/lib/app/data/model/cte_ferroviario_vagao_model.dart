import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteFerroviarioVagaoModel {
	int? id;
	int? idCteFerroviario;
	int? numeroVagao;
	double? capacidade;
	String? tipoVagao;
	double? pesoReal;
	double? pesoBc;
	CteFerroviarioModel? cteFerroviarioModel;

	CteFerroviarioVagaoModel({
		this.id,
		this.idCteFerroviario,
		this.numeroVagao,
		this.capacidade,
		this.tipoVagao,
		this.pesoReal,
		this.pesoBc,
		this.cteFerroviarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_vagao',
		'capacidade',
		'tipo_vagao',
		'peso_real',
		'peso_bc',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Vagao',
		'Capacidade',
		'Tipo Vagao',
		'Peso Real',
		'Peso Bc',
	];

	CteFerroviarioVagaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteFerroviario = jsonData['idCteFerroviario'];
		numeroVagao = jsonData['numeroVagao'];
		capacidade = jsonData['capacidade']?.toDouble();
		tipoVagao = CteFerroviarioVagaoDomain.getTipoVagao(jsonData['tipoVagao']);
		pesoReal = jsonData['pesoReal']?.toDouble();
		pesoBc = jsonData['pesoBc']?.toDouble();
		cteFerroviarioModel = jsonData['cteFerroviarioModel'] == null ? CteFerroviarioModel() : CteFerroviarioModel.fromJson(jsonData['cteFerroviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteFerroviario'] = idCteFerroviario != 0 ? idCteFerroviario : null;
		jsonData['numeroVagao'] = numeroVagao;
		jsonData['capacidade'] = capacidade;
		jsonData['tipoVagao'] = CteFerroviarioVagaoDomain.setTipoVagao(tipoVagao);
		jsonData['pesoReal'] = pesoReal;
		jsonData['pesoBc'] = pesoBc;
		jsonData['cteFerroviarioModel'] = cteFerroviarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteFerroviario = plutoRow.cells['idCteFerroviario']?.value;
		numeroVagao = plutoRow.cells['numeroVagao']?.value;
		capacidade = plutoRow.cells['capacidade']?.value?.toDouble();
		tipoVagao = plutoRow.cells['tipoVagao']?.value != '' ? plutoRow.cells['tipoVagao']?.value : 'AAA';
		pesoReal = plutoRow.cells['pesoReal']?.value?.toDouble();
		pesoBc = plutoRow.cells['pesoBc']?.value?.toDouble();
		cteFerroviarioModel = CteFerroviarioModel();
		cteFerroviarioModel?.fluxo = plutoRow.cells['cteFerroviarioModel']?.value;
	}	

	CteFerroviarioVagaoModel clone() {
		return CteFerroviarioVagaoModel(
			id: id,
			idCteFerroviario: idCteFerroviario,
			numeroVagao: numeroVagao,
			capacidade: capacidade,
			tipoVagao: tipoVagao,
			pesoReal: pesoReal,
			pesoBc: pesoBc,
		);			
	}

	
}