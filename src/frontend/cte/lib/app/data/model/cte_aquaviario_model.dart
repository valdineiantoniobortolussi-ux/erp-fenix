import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class CteAquaviarioModel {
	int? id;
	int? idCteCabecalho;
	double? valorPrestacao;
	double? afrmm;
	String? numeroBooking;
	String? numeroControle;
	String? idNavio;

	CteAquaviarioModel({
		this.id,
		this.idCteCabecalho,
		this.valorPrestacao,
		this.afrmm,
		this.numeroBooking,
		this.numeroControle,
		this.idNavio,
	});

	static List<String> dbColumns = <String>[
		'id',
		'valor_prestacao',
		'afrmm',
		'numero_booking',
		'numero_controle',
		'id_navio',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Valor Prestacao',
		'Afrmm',
		'Numero Booking',
		'Numero Controle',
		'Id Navio',
	];

	CteAquaviarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		valorPrestacao = jsonData['valorPrestacao']?.toDouble();
		afrmm = jsonData['afrmm']?.toDouble();
		numeroBooking = jsonData['numeroBooking'];
		numeroControle = jsonData['numeroControle'];
		idNavio = jsonData['idNavio'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['valorPrestacao'] = valorPrestacao;
		jsonData['afrmm'] = afrmm;
		jsonData['numeroBooking'] = numeroBooking;
		jsonData['numeroControle'] = numeroControle;
		jsonData['idNavio'] = idNavio;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		valorPrestacao = plutoRow.cells['valorPrestacao']?.value?.toDouble();
		afrmm = plutoRow.cells['afrmm']?.value?.toDouble();
		numeroBooking = plutoRow.cells['numeroBooking']?.value;
		numeroControle = plutoRow.cells['numeroControle']?.value;
		idNavio = plutoRow.cells['idNavio']?.value;
	}	

	CteAquaviarioModel clone() {
		return CteAquaviarioModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			valorPrestacao: valorPrestacao,
			afrmm: afrmm,
			numeroBooking: numeroBooking,
			numeroControle: numeroControle,
			idNavio: idNavio,
		);			
	}

	
}