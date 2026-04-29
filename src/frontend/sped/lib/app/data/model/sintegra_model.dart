import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:sped/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:sped/app/data/domain/domain_imports.dart';

class SintegraModel {
	int? id;
	DateTime? dataEmissao;
	DateTime? periodoInicial;
	DateTime? periodoFinal;
	String? codigoConvenio;
	String? inventario;
	String? finalidadeArquivo;

	SintegraModel({
		this.id,
		this.dataEmissao,
		this.periodoInicial,
		this.periodoFinal,
		this.codigoConvenio,
		this.inventario,
		this.finalidadeArquivo,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_emissao',
		'periodo_inicial',
		'periodo_final',
		'codigo_convenio',
		'inventario',
		'finalidade_arquivo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Emissao',
		'Periodo Inicial',
		'Periodo Final',
		'Codigo Convenio',
		'Inventario',
		'Finalidade Arquivo',
	];

	SintegraModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		dataEmissao = jsonData['dataEmissao'] != null ? DateTime.tryParse(jsonData['dataEmissao']) : null;
		periodoInicial = jsonData['periodoInicial'] != null ? DateTime.tryParse(jsonData['periodoInicial']) : null;
		periodoFinal = jsonData['periodoFinal'] != null ? DateTime.tryParse(jsonData['periodoFinal']) : null;
		codigoConvenio = SintegraDomain.getCodigoConvenio(jsonData['codigoConvenio']);
		inventario = SintegraDomain.getInventario(jsonData['inventario']);
		finalidadeArquivo = jsonData['finalidadeArquivo'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['dataEmissao'] = dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissao!) : null;
		jsonData['periodoInicial'] = periodoInicial != null ? DateFormat('yyyy-MM-ddT00:00:00').format(periodoInicial!) : null;
		jsonData['periodoFinal'] = periodoFinal != null ? DateFormat('yyyy-MM-ddT00:00:00').format(periodoFinal!) : null;
		jsonData['codigoConvenio'] = SintegraDomain.setCodigoConvenio(codigoConvenio);
		jsonData['inventario'] = SintegraDomain.setInventario(inventario);
		jsonData['finalidadeArquivo'] = finalidadeArquivo;
	
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
		codigoConvenio = plutoRow.cells['codigoConvenio']?.value != '' ? plutoRow.cells['codigoConvenio']?.value : '57/95';
		inventario = plutoRow.cells['inventario']?.value != '' ? plutoRow.cells['inventario']?.value : '00-Sem Inventário';
		finalidadeArquivo = plutoRow.cells['finalidadeArquivo']?.value;
	}	

	SintegraModel clone() {
		return SintegraModel(
			id: id,
			dataEmissao: dataEmissao,
			periodoInicial: periodoInicial,
			periodoFinal: periodoFinal,
			codigoConvenio: codigoConvenio,
			inventario: inventario,
			finalidadeArquivo: finalidadeArquivo,
		);			
	}

	
}