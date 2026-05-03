import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class NfeExportacaoModel {
	int? id;
	int? idNfeDetalhe;
	int? drawback;
	int? numeroRegistro;
	String? chaveAcesso;
	double? quantidade;

	NfeExportacaoModel({
		this.id,
		this.idNfeDetalhe,
		this.drawback,
		this.numeroRegistro,
		this.chaveAcesso,
		this.quantidade,
	});

	static List<String> dbColumns = <String>[
		'id',
		'drawback',
		'numero_registro',
		'chave_acesso',
		'quantidade',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Drawback',
		'Numero Registro',
		'Chave Acesso',
		'Quantidade',
	];

	NfeExportacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		drawback = jsonData['drawback'];
		numeroRegistro = jsonData['numeroRegistro'];
		chaveAcesso = jsonData['chaveAcesso'];
		quantidade = jsonData['quantidade']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['drawback'] = drawback;
		jsonData['numeroRegistro'] = numeroRegistro;
		jsonData['chaveAcesso'] = chaveAcesso;
		jsonData['quantidade'] = quantidade;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		drawback = plutoRow.cells['drawback']?.value;
		numeroRegistro = plutoRow.cells['numeroRegistro']?.value;
		chaveAcesso = plutoRow.cells['chaveAcesso']?.value;
		quantidade = plutoRow.cells['quantidade']?.value?.toDouble();
	}	

	NfeExportacaoModel clone() {
		return NfeExportacaoModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			drawback: drawback,
			numeroRegistro: numeroRegistro,
			chaveAcesso: chaveAcesso,
			quantidade: quantidade,
		);			
	}

	
}