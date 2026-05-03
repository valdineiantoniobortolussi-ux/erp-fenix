import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class VendaCondicoesParcelasModel {
	int? id;
	int? idVendaCondicoesPagamento;
	int? parcela;
	int? dias;
	double? taxa;

	VendaCondicoesParcelasModel({
		this.id,
		this.idVendaCondicoesPagamento,
		this.parcela,
		this.dias,
		this.taxa,
	});

	static List<String> dbColumns = <String>[
		'id',
		'parcela',
		'dias',
		'taxa',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Parcela',
		'Dias',
		'Taxa',
	];

	VendaCondicoesParcelasModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idVendaCondicoesPagamento = jsonData['idVendaCondicoesPagamento'];
		parcela = jsonData['parcela'];
		dias = jsonData['dias'];
		taxa = jsonData['taxa']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idVendaCondicoesPagamento'] = idVendaCondicoesPagamento != 0 ? idVendaCondicoesPagamento : null;
		jsonData['parcela'] = parcela;
		jsonData['dias'] = dias;
		jsonData['taxa'] = taxa;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idVendaCondicoesPagamento = plutoRow.cells['idVendaCondicoesPagamento']?.value;
		parcela = plutoRow.cells['parcela']?.value;
		dias = plutoRow.cells['dias']?.value;
		taxa = plutoRow.cells['taxa']?.value?.toDouble();
	}	

	VendaCondicoesParcelasModel clone() {
		return VendaCondicoesParcelasModel(
			id: id,
			idVendaCondicoesPagamento: idVendaCondicoesPagamento,
			parcela: parcela,
			dias: dias,
			taxa: taxa,
		);			
	}

	
}