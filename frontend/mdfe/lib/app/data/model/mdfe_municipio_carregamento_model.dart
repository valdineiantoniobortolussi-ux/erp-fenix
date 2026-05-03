import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class MdfeMunicipioCarregamentoModel {
	int? id;
	int? idMdfeCabecalho;
	String? codigoMunicipio;
	String? nomeMunicipio;

	MdfeMunicipioCarregamentoModel({
		this.id,
		this.idMdfeCabecalho,
		this.codigoMunicipio,
		this.nomeMunicipio,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo_municipio',
		'nome_municipio',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo Municipio',
		'Nome Municipio',
	];

	MdfeMunicipioCarregamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeCabecalho = jsonData['idMdfeCabecalho'];
		codigoMunicipio = jsonData['codigoMunicipio'];
		nomeMunicipio = jsonData['nomeMunicipio'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeCabecalho'] = idMdfeCabecalho != 0 ? idMdfeCabecalho : null;
		jsonData['codigoMunicipio'] = codigoMunicipio;
		jsonData['nomeMunicipio'] = nomeMunicipio;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idMdfeCabecalho = plutoRow.cells['idMdfeCabecalho']?.value;
		codigoMunicipio = plutoRow.cells['codigoMunicipio']?.value;
		nomeMunicipio = plutoRow.cells['nomeMunicipio']?.value;
	}	

	MdfeMunicipioCarregamentoModel clone() {
		return MdfeMunicipioCarregamentoModel(
			id: id,
			idMdfeCabecalho: idMdfeCabecalho,
			codigoMunicipio: codigoMunicipio,
			nomeMunicipio: nomeMunicipio,
		);			
	}

	
}