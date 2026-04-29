import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/data/domain/domain_imports.dart';

class CteFerroviarioModel {
	int? id;
	int? idCteCabecalho;
	String? tipoTrafego;
	String? responsavelFaturamento;
	String? ferroviaEmitenteCte;
	String? fluxo;
	String? idTrem;
	double? valorFrete;

	CteFerroviarioModel({
		this.id,
		this.idCteCabecalho,
		this.tipoTrafego,
		this.responsavelFaturamento,
		this.ferroviaEmitenteCte,
		this.fluxo,
		this.idTrem,
		this.valorFrete,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo_trafego',
		'responsavel_faturamento',
		'ferrovia_emitente_cte',
		'fluxo',
		'id_trem',
		'valor_frete',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo Trafego',
		'Responsavel Faturamento',
		'Ferrovia Emitente Cte',
		'Fluxo',
		'Id Trem',
		'Valor Frete',
	];

	CteFerroviarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		tipoTrafego = CteFerroviarioDomain.getTipoTrafego(jsonData['tipoTrafego']);
		responsavelFaturamento = CteFerroviarioDomain.getResponsavelFaturamento(jsonData['responsavelFaturamento']);
		ferroviaEmitenteCte = CteFerroviarioDomain.getFerroviaEmitenteCte(jsonData['ferroviaEmitenteCte']);
		fluxo = jsonData['fluxo'];
		idTrem = jsonData['idTrem'];
		valorFrete = jsonData['valorFrete']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['tipoTrafego'] = CteFerroviarioDomain.setTipoTrafego(tipoTrafego);
		jsonData['responsavelFaturamento'] = CteFerroviarioDomain.setResponsavelFaturamento(responsavelFaturamento);
		jsonData['ferroviaEmitenteCte'] = CteFerroviarioDomain.setFerroviaEmitenteCte(ferroviaEmitenteCte);
		jsonData['fluxo'] = fluxo;
		jsonData['idTrem'] = idTrem;
		jsonData['valorFrete'] = valorFrete;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		tipoTrafego = plutoRow.cells['tipoTrafego']?.value != '' ? plutoRow.cells['tipoTrafego']?.value : 'AAA';
		responsavelFaturamento = plutoRow.cells['responsavelFaturamento']?.value != '' ? plutoRow.cells['responsavelFaturamento']?.value : 'AAA';
		ferroviaEmitenteCte = plutoRow.cells['ferroviaEmitenteCte']?.value != '' ? plutoRow.cells['ferroviaEmitenteCte']?.value : 'AAA';
		fluxo = plutoRow.cells['fluxo']?.value;
		idTrem = plutoRow.cells['idTrem']?.value;
		valorFrete = plutoRow.cells['valorFrete']?.value?.toDouble();
	}	

	CteFerroviarioModel clone() {
		return CteFerroviarioModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			tipoTrafego: tipoTrafego,
			responsavelFaturamento: responsavelFaturamento,
			ferroviaEmitenteCte: ferroviaEmitenteCte,
			fluxo: fluxo,
			idTrem: idTrem,
			valorFrete: valorFrete,
		);			
	}

	
}