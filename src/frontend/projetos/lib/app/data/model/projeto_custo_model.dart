import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:projetos/app/data/model/model_imports.dart';

class ProjetoCustoModel {
	int? id;
	int? idProjetoPrincipal;
	int? idFinNaturezaFinanceira;
	String? nome;
	double? valorMensal;
	double? valorTotal;
	String? justificativa;
	FinNaturezaFinanceiraModel? finNaturezaFinanceiraModel;

	ProjetoCustoModel({
		this.id,
		this.idProjetoPrincipal,
		this.idFinNaturezaFinanceira,
		this.nome,
		this.valorMensal,
		this.valorTotal,
		this.justificativa,
		this.finNaturezaFinanceiraModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'valor_mensal',
		'valor_total',
		'justificativa',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Valor Mensal',
		'Valor Total',
		'Justificativa',
	];

	ProjetoCustoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idProjetoPrincipal = jsonData['idProjetoPrincipal'];
		idFinNaturezaFinanceira = jsonData['idFinNaturezaFinanceira'];
		nome = jsonData['nome'];
		valorMensal = jsonData['valorMensal']?.toDouble();
		valorTotal = jsonData['valorTotal']?.toDouble();
		justificativa = jsonData['justificativa'];
		finNaturezaFinanceiraModel = jsonData['finNaturezaFinanceiraModel'] == null ? FinNaturezaFinanceiraModel() : FinNaturezaFinanceiraModel.fromJson(jsonData['finNaturezaFinanceiraModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idProjetoPrincipal'] = idProjetoPrincipal != 0 ? idProjetoPrincipal : null;
		jsonData['idFinNaturezaFinanceira'] = idFinNaturezaFinanceira != 0 ? idFinNaturezaFinanceira : null;
		jsonData['nome'] = nome;
		jsonData['valorMensal'] = valorMensal;
		jsonData['valorTotal'] = valorTotal;
		jsonData['justificativa'] = justificativa;
		jsonData['finNaturezaFinanceiraModel'] = finNaturezaFinanceiraModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idProjetoPrincipal = plutoRow.cells['idProjetoPrincipal']?.value;
		idFinNaturezaFinanceira = plutoRow.cells['idFinNaturezaFinanceira']?.value;
		nome = plutoRow.cells['nome']?.value;
		valorMensal = plutoRow.cells['valorMensal']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		justificativa = plutoRow.cells['justificativa']?.value;
		finNaturezaFinanceiraModel = FinNaturezaFinanceiraModel();
		finNaturezaFinanceiraModel?.descricao = plutoRow.cells['finNaturezaFinanceiraModel']?.value;
	}	

	ProjetoCustoModel clone() {
		return ProjetoCustoModel(
			id: id,
			idProjetoPrincipal: idProjetoPrincipal,
			idFinNaturezaFinanceira: idFinNaturezaFinanceira,
			nome: nome,
			valorMensal: valorMensal,
			valorTotal: valorTotal,
			justificativa: justificativa,
		);			
	}

	
}