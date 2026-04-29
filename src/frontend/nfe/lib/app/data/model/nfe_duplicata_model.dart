import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class NfeDuplicataModel {
	int? id;
	int? idNfeFatura;
	String? numero;
	DateTime? dataVencimento;
	double? valor;
	NfeFaturaModel? nfeFaturaModel;

	NfeDuplicataModel({
		this.id,
		this.idNfeFatura,
		this.numero,
		this.dataVencimento,
		this.valor,
		this.nfeFaturaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'data_vencimento',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Data Vencimento',
		'Valor',
	];

	NfeDuplicataModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeFatura = jsonData['idNfeFatura'];
		numero = jsonData['numero'];
		dataVencimento = jsonData['dataVencimento'] != null ? DateTime.tryParse(jsonData['dataVencimento']) : null;
		valor = jsonData['valor']?.toDouble();
		nfeFaturaModel = jsonData['nfeFaturaModel'] == null ? NfeFaturaModel() : NfeFaturaModel.fromJson(jsonData['nfeFaturaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeFatura'] = idNfeFatura != 0 ? idNfeFatura : null;
		jsonData['numero'] = numero;
		jsonData['dataVencimento'] = dataVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataVencimento!) : null;
		jsonData['valor'] = valor;
		jsonData['nfeFaturaModel'] = nfeFaturaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeFatura = plutoRow.cells['idNfeFatura']?.value;
		numero = plutoRow.cells['numero']?.value;
		dataVencimento = Util.stringToDate(plutoRow.cells['dataVencimento']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
		nfeFaturaModel = NfeFaturaModel();
		nfeFaturaModel?.numero = plutoRow.cells['nfeFaturaModel']?.value;
	}	

	NfeDuplicataModel clone() {
		return NfeDuplicataModel(
			id: id,
			idNfeFatura: idNfeFatura,
			numero: numero,
			dataVencimento: dataVencimento,
			valor: valor,
		);			
	}

	
}