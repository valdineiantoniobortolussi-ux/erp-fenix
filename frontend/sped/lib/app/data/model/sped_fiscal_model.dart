import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:sped/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:sped/app/data/domain/domain_imports.dart';

class SpedFiscalModel {
	int? id;
	DateTime? dataEmissao;
	DateTime? periodoInicial;
	DateTime? periodoFinal;
	String? perfilApresentacao;
	String? finalidadeArquivo;
	String? versaoLayout;

	SpedFiscalModel({
		this.id,
		this.dataEmissao,
		this.periodoInicial,
		this.periodoFinal,
		this.perfilApresentacao,
		this.finalidadeArquivo,
		this.versaoLayout,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_emissao',
		'periodo_inicial',
		'periodo_final',
		'perfil_apresentacao',
		'finalidade_arquivo',
		'versao_layout',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Emissao',
		'Periodo Inicial',
		'Periodo Final',
		'Perfil Apresentacao',
		'Finalidade Arquivo',
		'Versao Layout',
	];

	SpedFiscalModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		dataEmissao = jsonData['dataEmissao'] != null ? DateTime.tryParse(jsonData['dataEmissao']) : null;
		periodoInicial = jsonData['periodoInicial'] != null ? DateTime.tryParse(jsonData['periodoInicial']) : null;
		periodoFinal = jsonData['periodoFinal'] != null ? DateTime.tryParse(jsonData['periodoFinal']) : null;
		perfilApresentacao = SpedFiscalDomain.getPerfilApresentacao(jsonData['perfilApresentacao']);
		finalidadeArquivo = jsonData['finalidadeArquivo'];
		versaoLayout = jsonData['versaoLayout'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['dataEmissao'] = dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissao!) : null;
		jsonData['periodoInicial'] = periodoInicial != null ? DateFormat('yyyy-MM-ddT00:00:00').format(periodoInicial!) : null;
		jsonData['periodoFinal'] = periodoFinal != null ? DateFormat('yyyy-MM-ddT00:00:00').format(periodoFinal!) : null;
		jsonData['perfilApresentacao'] = SpedFiscalDomain.setPerfilApresentacao(perfilApresentacao);
		jsonData['finalidadeArquivo'] = finalidadeArquivo;
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
		perfilApresentacao = plutoRow.cells['perfilApresentacao']?.value != '' ? plutoRow.cells['perfilApresentacao']?.value : 'A';
		finalidadeArquivo = plutoRow.cells['finalidadeArquivo']?.value;
		versaoLayout = plutoRow.cells['versaoLayout']?.value;
	}	

	SpedFiscalModel clone() {
		return SpedFiscalModel(
			id: id,
			dataEmissao: dataEmissao,
			periodoInicial: periodoInicial,
			periodoFinal: periodoFinal,
			perfilApresentacao: perfilApresentacao,
			finalidadeArquivo: finalidadeArquivo,
			versaoLayout: versaoLayout,
		);			
	}

	
}