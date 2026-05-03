import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilDreDetalheModel {
	int? id;
	int? idContabilDreCabecalho;
	String? classificacao;
	String? descricao;
	String? formaCalculo;
	String? sinal;
	String? natureza;
	double? valor;

	ContabilDreDetalheModel({
		this.id,
		this.idContabilDreCabecalho,
		this.classificacao,
		this.descricao,
		this.formaCalculo,
		this.sinal,
		this.natureza,
		this.valor,
	});

	static List<String> dbColumns = <String>[
		'id',
		'classificacao',
		'descricao',
		'forma_calculo',
		'sinal',
		'natureza',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Classificacao',
		'Descricao',
		'Forma Calculo',
		'Sinal',
		'Natureza',
		'Valor',
	];

	ContabilDreDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContabilDreCabecalho = jsonData['idContabilDreCabecalho'];
		classificacao = jsonData['classificacao'];
		descricao = jsonData['descricao'];
		formaCalculo = ContabilDreDetalheDomain.getFormaCalculo(jsonData['formaCalculo']);
		sinal = ContabilDreDetalheDomain.getSinal(jsonData['sinal']);
		natureza = ContabilDreDetalheDomain.getNatureza(jsonData['natureza']);
		valor = jsonData['valor']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContabilDreCabecalho'] = idContabilDreCabecalho != 0 ? idContabilDreCabecalho : null;
		jsonData['classificacao'] = classificacao;
		jsonData['descricao'] = descricao;
		jsonData['formaCalculo'] = ContabilDreDetalheDomain.setFormaCalculo(formaCalculo);
		jsonData['sinal'] = ContabilDreDetalheDomain.setSinal(sinal);
		jsonData['natureza'] = ContabilDreDetalheDomain.setNatureza(natureza);
		jsonData['valor'] = valor;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContabilDreCabecalho = plutoRow.cells['idContabilDreCabecalho']?.value;
		classificacao = plutoRow.cells['classificacao']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		formaCalculo = plutoRow.cells['formaCalculo']?.value != '' ? plutoRow.cells['formaCalculo']?.value : 'Sintética';
		sinal = plutoRow.cells['sinal']?.value != '' ? plutoRow.cells['sinal']?.value : '+';
		natureza = plutoRow.cells['natureza']?.value != '' ? plutoRow.cells['natureza']?.value : 'Credora';
		valor = plutoRow.cells['valor']?.value?.toDouble();
	}	

	ContabilDreDetalheModel clone() {
		return ContabilDreDetalheModel(
			id: id,
			idContabilDreCabecalho: idContabilDreCabecalho,
			classificacao: classificacao,
			descricao: descricao,
			formaCalculo: formaCalculo,
			sinal: sinal,
			natureza: natureza,
			valor: valor,
		);			
	}

	
}