import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:sped/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:sped/app/data/domain/domain_imports.dart';

class SpedContabilModel {
	int? id;
	DateTime? dataEmissao;
	DateTime? periodoInicial;
	DateTime? periodoFinal;
	String? formaEscrituracao;
	String? versaoLayout;

	SpedContabilModel({
		this.id,
		this.dataEmissao,
		this.periodoInicial,
		this.periodoFinal,
		this.formaEscrituracao,
		this.versaoLayout,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_emissao',
		'periodo_inicial',
		'periodo_final',
		'forma_escrituracao',
		'versao_layout',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Emissao',
		'Periodo Inicial',
		'Periodo Final',
		'Forma Escrituracao',
		'Versao Layout',
	];

	SpedContabilModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		dataEmissao = jsonData['dataEmissao'] != null ? DateTime.tryParse(jsonData['dataEmissao']) : null;
		periodoInicial = jsonData['periodoInicial'] != null ? DateTime.tryParse(jsonData['periodoInicial']) : null;
		periodoFinal = jsonData['periodoFinal'] != null ? DateTime.tryParse(jsonData['periodoFinal']) : null;
		formaEscrituracao = SpedContabilDomain.getFormaEscrituracao(jsonData['formaEscrituracao']);
		versaoLayout = jsonData['versaoLayout'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['dataEmissao'] = dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissao!) : null;
		jsonData['periodoInicial'] = periodoInicial != null ? DateFormat('yyyy-MM-ddT00:00:00').format(periodoInicial!) : null;
		jsonData['periodoFinal'] = periodoFinal != null ? DateFormat('yyyy-MM-ddT00:00:00').format(periodoFinal!) : null;
		jsonData['formaEscrituracao'] = SpedContabilDomain.setFormaEscrituracao(formaEscrituracao);
		jsonData['versaoLayout'] = versaoLayout;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		dataEmissao = Util.stringToDate(plutoRow.cells['dataEmissao']?.value);
		periodoInicial = Util.stringToDate(plutoRow.cells['periodoInicial']?.value);
		periodoFinal = Util.stringToDate(plutoRow.cells['periodoFinal']?.value);
		formaEscrituracao = plutoRow.cells['formaEscrituracao']?.value != '' ? plutoRow.cells['formaEscrituracao']?.value : 'G-Diário Geral';
		versaoLayout = plutoRow.cells['versaoLayout']?.value;
	}	

	SpedContabilModel clone() {
		return SpedContabilModel(
			id: id,
			dataEmissao: dataEmissao,
			periodoInicial: periodoInicial,
			periodoFinal: periodoFinal,
			formaEscrituracao: formaEscrituracao,
			versaoLayout: versaoLayout,
		);			
	}

	
}