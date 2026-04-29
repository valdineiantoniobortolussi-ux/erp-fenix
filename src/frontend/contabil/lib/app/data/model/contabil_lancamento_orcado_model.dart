import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/data/model/model_imports.dart';

class ContabilLancamentoOrcadoModel {
	int? id;
	int? idContabilConta;
	String? ano;
	double? janeiro;
	double? fevereiro;
	double? marco;
	double? abril;
	double? maio;
	double? junho;
	double? julho;
	double? agosto;
	double? setembro;
	double? outubro;
	double? novembro;
	double? dezembro;
	ContabilContaModel? contabilContaModel;

	ContabilLancamentoOrcadoModel({
		this.id,
		this.idContabilConta,
		this.ano,
		this.janeiro,
		this.fevereiro,
		this.marco,
		this.abril,
		this.maio,
		this.junho,
		this.julho,
		this.agosto,
		this.setembro,
		this.outubro,
		this.novembro,
		this.dezembro,
		this.contabilContaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'ano',
		'janeiro',
		'fevereiro',
		'marco',
		'abril',
		'maio',
		'junho',
		'julho',
		'agosto',
		'setembro',
		'outubro',
		'novembro',
		'dezembro',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Ano',
		'Janeiro',
		'Fevereiro',
		'Marco',
		'Abril',
		'Maio',
		'Junho',
		'Julho',
		'Agosto',
		'Setembro',
		'Outubro',
		'Novembro',
		'Dezembro',
	];

	ContabilLancamentoOrcadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContabilConta = jsonData['idContabilConta'];
		ano = jsonData['ano'];
		janeiro = jsonData['janeiro']?.toDouble();
		fevereiro = jsonData['fevereiro']?.toDouble();
		marco = jsonData['marco']?.toDouble();
		abril = jsonData['abril']?.toDouble();
		maio = jsonData['maio']?.toDouble();
		junho = jsonData['junho']?.toDouble();
		julho = jsonData['julho']?.toDouble();
		agosto = jsonData['agosto']?.toDouble();
		setembro = jsonData['setembro']?.toDouble();
		outubro = jsonData['outubro']?.toDouble();
		novembro = jsonData['novembro']?.toDouble();
		dezembro = jsonData['dezembro']?.toDouble();
		contabilContaModel = jsonData['contabilContaModel'] == null ? ContabilContaModel() : ContabilContaModel.fromJson(jsonData['contabilContaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContabilConta'] = idContabilConta != 0 ? idContabilConta : null;
		jsonData['ano'] = ano;
		jsonData['janeiro'] = janeiro;
		jsonData['fevereiro'] = fevereiro;
		jsonData['marco'] = marco;
		jsonData['abril'] = abril;
		jsonData['maio'] = maio;
		jsonData['junho'] = junho;
		jsonData['julho'] = julho;
		jsonData['agosto'] = agosto;
		jsonData['setembro'] = setembro;
		jsonData['outubro'] = outubro;
		jsonData['novembro'] = novembro;
		jsonData['dezembro'] = dezembro;
		jsonData['contabilContaModel'] = contabilContaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContabilConta = plutoRow.cells['idContabilConta']?.value;
		ano = plutoRow.cells['ano']?.value;
		janeiro = plutoRow.cells['janeiro']?.value?.toDouble();
		fevereiro = plutoRow.cells['fevereiro']?.value?.toDouble();
		marco = plutoRow.cells['marco']?.value?.toDouble();
		abril = plutoRow.cells['abril']?.value?.toDouble();
		maio = plutoRow.cells['maio']?.value?.toDouble();
		junho = plutoRow.cells['junho']?.value?.toDouble();
		julho = plutoRow.cells['julho']?.value?.toDouble();
		agosto = plutoRow.cells['agosto']?.value?.toDouble();
		setembro = plutoRow.cells['setembro']?.value?.toDouble();
		outubro = plutoRow.cells['outubro']?.value?.toDouble();
		novembro = plutoRow.cells['novembro']?.value?.toDouble();
		dezembro = plutoRow.cells['dezembro']?.value?.toDouble();
		contabilContaModel = ContabilContaModel();
		contabilContaModel?.descricao = plutoRow.cells['contabilContaModel']?.value;
	}	

	ContabilLancamentoOrcadoModel clone() {
		return ContabilLancamentoOrcadoModel(
			id: id,
			idContabilConta: idContabilConta,
			ano: ano,
			janeiro: janeiro,
			fevereiro: fevereiro,
			marco: marco,
			abril: abril,
			maio: maio,
			junho: junho,
			julho: julho,
			agosto: agosto,
			setembro: setembro,
			outubro: outubro,
			novembro: novembro,
			dezembro: dezembro,
		);			
	}

	
}