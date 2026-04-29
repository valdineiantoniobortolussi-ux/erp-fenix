import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class FinChequeEmitidoModel {
	int? id;
	int? idCheque;
	DateTime? dataEmissao;
	DateTime? bomPara;
	DateTime? dataCompensacao;
	double? valor;
	String? nominalA;
	ChequeModel? chequeModel;

	FinChequeEmitidoModel({
		this.id,
		this.idCheque,
		this.dataEmissao,
		this.bomPara,
		this.dataCompensacao,
		this.valor,
		this.nominalA,
		this.chequeModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_emissao',
		'bom_para',
		'data_compensacao',
		'valor',
		'nominal_a',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Emissao',
		'Bom Para',
		'Data Compensacao',
		'Valor',
		'Nominal A',
	];

	FinChequeEmitidoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCheque = jsonData['idCheque'];
		dataEmissao = jsonData['dataEmissao'] != null ? DateTime.tryParse(jsonData['dataEmissao']) : null;
		bomPara = jsonData['bomPara'] != null ? DateTime.tryParse(jsonData['bomPara']) : null;
		dataCompensacao = jsonData['dataCompensacao'] != null ? DateTime.tryParse(jsonData['dataCompensacao']) : null;
		valor = jsonData['valor']?.toDouble();
		nominalA = jsonData['nominalA'];
		chequeModel = jsonData['chequeModel'] == null ? ChequeModel() : ChequeModel.fromJson(jsonData['chequeModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCheque'] = idCheque != 0 ? idCheque : null;
		jsonData['dataEmissao'] = dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissao!) : null;
		jsonData['bomPara'] = bomPara != null ? DateFormat('yyyy-MM-ddT00:00:00').format(bomPara!) : null;
		jsonData['dataCompensacao'] = dataCompensacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCompensacao!) : null;
		jsonData['valor'] = valor;
		jsonData['nominalA'] = nominalA;
		jsonData['chequeModel'] = chequeModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCheque = plutoRow.cells['idCheque']?.value;
		dataEmissao = Util.stringToDate(plutoRow.cells['dataEmissao']?.value);
		bomPara = Util.stringToDate(plutoRow.cells['bomPara']?.value);
		dataCompensacao = Util.stringToDate(plutoRow.cells['dataCompensacao']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
		nominalA = plutoRow.cells['nominalA']?.value;
		chequeModel = ChequeModel();
		chequeModel?.numero = plutoRow.cells['chequeModel']?.value;
	}	

	FinChequeEmitidoModel clone() {
		return FinChequeEmitidoModel(
			id: id,
			idCheque: idCheque,
			dataEmissao: dataEmissao,
			bomPara: bomPara,
			dataCompensacao: dataCompensacao,
			valor: valor,
			nominalA: nominalA,
		);			
	}

	
}