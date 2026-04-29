import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/model/model_imports.dart';

class NfeTransporteVolumeModel {
	int? id;
	int? idNfeTransporte;
	int? quantidade;
	String? especie;
	String? marca;
	String? numeracao;
	double? pesoLiquido;
	double? pesoBruto;
	NfeTransporteModel? nfeTransporteModel;

	NfeTransporteVolumeModel({
		this.id,
		this.idNfeTransporte,
		this.quantidade,
		this.especie,
		this.marca,
		this.numeracao,
		this.pesoLiquido,
		this.pesoBruto,
		this.nfeTransporteModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'quantidade',
		'especie',
		'marca',
		'numeracao',
		'peso_liquido',
		'peso_bruto',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade',
		'Especie',
		'Marca',
		'Numeracao',
		'Peso Liquido',
		'Peso Bruto',
	];

	NfeTransporteVolumeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeTransporte = jsonData['idNfeTransporte'];
		quantidade = jsonData['quantidade'];
		especie = jsonData['especie'];
		marca = jsonData['marca'];
		numeracao = jsonData['numeracao'];
		pesoLiquido = jsonData['pesoLiquido']?.toDouble();
		pesoBruto = jsonData['pesoBruto']?.toDouble();
		nfeTransporteModel = jsonData['nfeTransporteModel'] == null ? NfeTransporteModel() : NfeTransporteModel.fromJson(jsonData['nfeTransporteModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeTransporte'] = idNfeTransporte != 0 ? idNfeTransporte : null;
		jsonData['quantidade'] = quantidade;
		jsonData['especie'] = especie;
		jsonData['marca'] = marca;
		jsonData['numeracao'] = numeracao;
		jsonData['pesoLiquido'] = pesoLiquido;
		jsonData['pesoBruto'] = pesoBruto;
		jsonData['nfeTransporteModel'] = nfeTransporteModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeTransporte = plutoRow.cells['idNfeTransporte']?.value;
		quantidade = plutoRow.cells['quantidade']?.value;
		especie = plutoRow.cells['especie']?.value;
		marca = plutoRow.cells['marca']?.value;
		numeracao = plutoRow.cells['numeracao']?.value;
		pesoLiquido = plutoRow.cells['pesoLiquido']?.value?.toDouble();
		pesoBruto = plutoRow.cells['pesoBruto']?.value?.toDouble();
		nfeTransporteModel = NfeTransporteModel();
		nfeTransporteModel?.cnpj = plutoRow.cells['nfeTransporteModel']?.value;
	}	

	NfeTransporteVolumeModel clone() {
		return NfeTransporteVolumeModel(
			id: id,
			idNfeTransporte: idNfeTransporte,
			quantidade: quantidade,
			especie: especie,
			marca: marca,
			numeracao: numeracao,
			pesoLiquido: pesoLiquido,
			pesoBruto: pesoBruto,
		);			
	}

	
}