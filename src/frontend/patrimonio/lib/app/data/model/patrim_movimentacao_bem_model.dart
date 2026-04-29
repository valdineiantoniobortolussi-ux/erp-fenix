import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class PatrimMovimentacaoBemModel {
	int? id;
	int? idPatrimBem;
	int? idPatrimTipoMovimentacao;
	DateTime? dataMovimentacao;
	String? responsavel;
	PatrimTipoMovimentacaoModel? patrimTipoMovimentacaoModel;

	PatrimMovimentacaoBemModel({
		this.id,
		this.idPatrimBem,
		this.idPatrimTipoMovimentacao,
		this.dataMovimentacao,
		this.responsavel,
		this.patrimTipoMovimentacaoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_movimentacao',
		'responsavel',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Movimentacao',
		'Responsavel',
	];

	PatrimMovimentacaoBemModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPatrimBem = jsonData['idPatrimBem'];
		idPatrimTipoMovimentacao = jsonData['idPatrimTipoMovimentacao'];
		dataMovimentacao = jsonData['dataMovimentacao'] != null ? DateTime.tryParse(jsonData['dataMovimentacao']) : null;
		responsavel = jsonData['responsavel'];
		patrimTipoMovimentacaoModel = jsonData['patrimTipoMovimentacaoModel'] == null ? PatrimTipoMovimentacaoModel() : PatrimTipoMovimentacaoModel.fromJson(jsonData['patrimTipoMovimentacaoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPatrimBem'] = idPatrimBem != 0 ? idPatrimBem : null;
		jsonData['idPatrimTipoMovimentacao'] = idPatrimTipoMovimentacao != 0 ? idPatrimTipoMovimentacao : null;
		jsonData['dataMovimentacao'] = dataMovimentacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataMovimentacao!) : null;
		jsonData['responsavel'] = responsavel;
		jsonData['patrimTipoMovimentacaoModel'] = patrimTipoMovimentacaoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPatrimBem = plutoRow.cells['idPatrimBem']?.value;
		idPatrimTipoMovimentacao = plutoRow.cells['idPatrimTipoMovimentacao']?.value;
		dataMovimentacao = Util.stringToDate(plutoRow.cells['dataMovimentacao']?.value);
		responsavel = plutoRow.cells['responsavel']?.value;
		patrimTipoMovimentacaoModel = PatrimTipoMovimentacaoModel();
		patrimTipoMovimentacaoModel?.nome = plutoRow.cells['patrimTipoMovimentacaoModel']?.value;
	}	

	PatrimMovimentacaoBemModel clone() {
		return PatrimMovimentacaoBemModel(
			id: id,
			idPatrimBem: idPatrimBem,
			idPatrimTipoMovimentacao: idPatrimTipoMovimentacao,
			dataMovimentacao: dataMovimentacao,
			responsavel: responsavel,
		);			
	}

	
}