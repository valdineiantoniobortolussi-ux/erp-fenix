import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/data/model/model_imports.dart';

class FolhaLancamentoDetalheModel {
	int? id;
	int? idFolhaLancamentoCabecalho;
	int? idFolhaEvento;
	double? origem;
	double? provento;
	double? desconto;
	FolhaEventoModel? folhaEventoModel;

	FolhaLancamentoDetalheModel({
		this.id,
		this.idFolhaLancamentoCabecalho,
		this.idFolhaEvento,
		this.origem,
		this.provento,
		this.desconto,
		this.folhaEventoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'origem',
		'provento',
		'desconto',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Origem',
		'Provento',
		'Desconto',
	];

	FolhaLancamentoDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFolhaLancamentoCabecalho = jsonData['idFolhaLancamentoCabecalho'];
		idFolhaEvento = jsonData['idFolhaEvento'];
		origem = jsonData['origem']?.toDouble();
		provento = jsonData['provento']?.toDouble();
		desconto = jsonData['desconto']?.toDouble();
		folhaEventoModel = jsonData['folhaEventoModel'] == null ? FolhaEventoModel() : FolhaEventoModel.fromJson(jsonData['folhaEventoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFolhaLancamentoCabecalho'] = idFolhaLancamentoCabecalho != 0 ? idFolhaLancamentoCabecalho : null;
		jsonData['idFolhaEvento'] = idFolhaEvento != 0 ? idFolhaEvento : null;
		jsonData['origem'] = origem;
		jsonData['provento'] = provento;
		jsonData['desconto'] = desconto;
		jsonData['folhaEventoModel'] = folhaEventoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFolhaLancamentoCabecalho = plutoRow.cells['idFolhaLancamentoCabecalho']?.value;
		idFolhaEvento = plutoRow.cells['idFolhaEvento']?.value;
		origem = plutoRow.cells['origem']?.value?.toDouble();
		provento = plutoRow.cells['provento']?.value?.toDouble();
		desconto = plutoRow.cells['desconto']?.value?.toDouble();
		folhaEventoModel = FolhaEventoModel();
		folhaEventoModel?.nome = plutoRow.cells['folhaEventoModel']?.value;
	}	

	FolhaLancamentoDetalheModel clone() {
		return FolhaLancamentoDetalheModel(
			id: id,
			idFolhaLancamentoCabecalho: idFolhaLancamentoCabecalho,
			idFolhaEvento: idFolhaEvento,
			origem: origem,
			provento: provento,
			desconto: desconto,
		);			
	}

	
}