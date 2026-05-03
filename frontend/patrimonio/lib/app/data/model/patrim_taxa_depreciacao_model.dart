import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class PatrimTaxaDepreciacaoModel {
	int? id;
	String? ncm;
	String? bem;
	double? vida;
	double? taxa;

	PatrimTaxaDepreciacaoModel({
		this.id,
		this.ncm,
		this.bem,
		this.vida,
		this.taxa,
	});

	static List<String> dbColumns = <String>[
		'id',
		'ncm',
		'bem',
		'vida',
		'taxa',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Ncm',
		'Bem',
		'Vida',
		'Taxa',
	];

	PatrimTaxaDepreciacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		ncm = jsonData['ncm'];
		bem = jsonData['bem'];
		vida = jsonData['vida']?.toDouble();
		taxa = jsonData['taxa']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['ncm'] = ncm;
		jsonData['bem'] = bem;
		jsonData['vida'] = vida;
		jsonData['taxa'] = taxa;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		ncm = plutoRow.cells['ncm']?.value;
		bem = plutoRow.cells['bem']?.value;
		vida = plutoRow.cells['vida']?.value?.toDouble();
		taxa = plutoRow.cells['taxa']?.value?.toDouble();
	}	

	PatrimTaxaDepreciacaoModel clone() {
		return PatrimTaxaDepreciacaoModel(
			id: id,
			ncm: ncm,
			bem: bem,
			vida: vida,
			taxa: taxa,
		);			
	}

	
}