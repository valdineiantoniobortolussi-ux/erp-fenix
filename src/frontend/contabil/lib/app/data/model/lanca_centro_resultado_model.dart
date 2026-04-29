import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class LancaCentroResultadoModel {
	int? id;
	int? idCentroResultado;
	double? valor;
	DateTime? dataLancamento;
	DateTime? dataInclusao;
	String? origemDeRateio;
	String? historico;
	CentroResultadoModel? centroResultadoModel;

	LancaCentroResultadoModel({
		this.id,
		this.idCentroResultado,
		this.valor,
		this.dataLancamento,
		this.dataInclusao,
		this.origemDeRateio,
		this.historico,
		this.centroResultadoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'valor',
		'data_lancamento',
		'data_inclusao',
		'origem_de_rateio',
		'historico',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Valor',
		'Data Lancamento',
		'Data Inclusao',
		'Origem De Rateio',
		'Historico',
	];

	LancaCentroResultadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCentroResultado = jsonData['idCentroResultado'];
		valor = jsonData['valor']?.toDouble();
		dataLancamento = jsonData['dataLancamento'] != null ? DateTime.tryParse(jsonData['dataLancamento']) : null;
		dataInclusao = jsonData['dataInclusao'] != null ? DateTime.tryParse(jsonData['dataInclusao']) : null;
		origemDeRateio = LancaCentroResultadoDomain.getOrigemDeRateio(jsonData['origemDeRateio']);
		historico = jsonData['historico'];
		centroResultadoModel = jsonData['centroResultadoModel'] == null ? CentroResultadoModel() : CentroResultadoModel.fromJson(jsonData['centroResultadoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCentroResultado'] = idCentroResultado != 0 ? idCentroResultado : null;
		jsonData['valor'] = valor;
		jsonData['dataLancamento'] = dataLancamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataLancamento!) : null;
		jsonData['dataInclusao'] = dataInclusao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInclusao!) : null;
		jsonData['origemDeRateio'] = LancaCentroResultadoDomain.setOrigemDeRateio(origemDeRateio);
		jsonData['historico'] = historico;
		jsonData['centroResultadoModel'] = centroResultadoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCentroResultado = plutoRow.cells['idCentroResultado']?.value;
		valor = plutoRow.cells['valor']?.value?.toDouble();
		dataLancamento = Util.stringToDate(plutoRow.cells['dataLancamento']?.value);
		dataInclusao = Util.stringToDate(plutoRow.cells['dataInclusao']?.value);
		origemDeRateio = plutoRow.cells['origemDeRateio']?.value != '' ? plutoRow.cells['origemDeRateio']?.value : 'Sim';
		historico = plutoRow.cells['historico']?.value;
		centroResultadoModel = CentroResultadoModel();
		centroResultadoModel?.descricao = plutoRow.cells['centroResultadoModel']?.value;
	}	

	LancaCentroResultadoModel clone() {
		return LancaCentroResultadoModel(
			id: id,
			idCentroResultado: idCentroResultado,
			valor: valor,
			dataLancamento: dataLancamento,
			dataInclusao: dataInclusao,
			origemDeRateio: origemDeRateio,
			historico: historico,
		);			
	}

	
}