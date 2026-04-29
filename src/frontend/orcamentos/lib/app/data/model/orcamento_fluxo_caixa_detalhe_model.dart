import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:orcamentos/app/data/model/model_imports.dart';

class OrcamentoFluxoCaixaDetalheModel {
	int? id;
	int? idOrcamentoFluxoCaixa;
	int? idFinNaturezaFinanceira;
	String? periodo;
	double? valorOrcado;
	double? valorRealizado;
	double? taxaVariacao;
	double? valorVariacao;
	FinNaturezaFinanceiraModel? finNaturezaFinanceiraModel;

	OrcamentoFluxoCaixaDetalheModel({
		this.id,
		this.idOrcamentoFluxoCaixa,
		this.idFinNaturezaFinanceira,
		this.periodo,
		this.valorOrcado,
		this.valorRealizado,
		this.taxaVariacao,
		this.valorVariacao,
		this.finNaturezaFinanceiraModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'periodo',
		'valor_orcado',
		'valor_realizado',
		'taxa_variacao',
		'valor_variacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Periodo',
		'Valor Orcado',
		'Valor Realizado',
		'Taxa Variacao',
		'Valor Variacao',
	];

	OrcamentoFluxoCaixaDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idOrcamentoFluxoCaixa = jsonData['idOrcamentoFluxoCaixa'];
		idFinNaturezaFinanceira = jsonData['idFinNaturezaFinanceira'];
		periodo = jsonData['periodo'];
		valorOrcado = jsonData['valorOrcado']?.toDouble();
		valorRealizado = jsonData['valorRealizado']?.toDouble();
		taxaVariacao = jsonData['taxaVariacao']?.toDouble();
		valorVariacao = jsonData['valorVariacao']?.toDouble();
		finNaturezaFinanceiraModel = jsonData['finNaturezaFinanceiraModel'] == null ? FinNaturezaFinanceiraModel() : FinNaturezaFinanceiraModel.fromJson(jsonData['finNaturezaFinanceiraModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idOrcamentoFluxoCaixa'] = idOrcamentoFluxoCaixa != 0 ? idOrcamentoFluxoCaixa : null;
		jsonData['idFinNaturezaFinanceira'] = idFinNaturezaFinanceira != 0 ? idFinNaturezaFinanceira : null;
		jsonData['periodo'] = periodo;
		jsonData['valorOrcado'] = valorOrcado;
		jsonData['valorRealizado'] = valorRealizado;
		jsonData['taxaVariacao'] = taxaVariacao;
		jsonData['valorVariacao'] = valorVariacao;
		jsonData['finNaturezaFinanceiraModel'] = finNaturezaFinanceiraModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idOrcamentoFluxoCaixa = plutoRow.cells['idOrcamentoFluxoCaixa']?.value;
		idFinNaturezaFinanceira = plutoRow.cells['idFinNaturezaFinanceira']?.value;
		periodo = plutoRow.cells['periodo']?.value;
		valorOrcado = plutoRow.cells['valorOrcado']?.value?.toDouble();
		valorRealizado = plutoRow.cells['valorRealizado']?.value?.toDouble();
		taxaVariacao = plutoRow.cells['taxaVariacao']?.value?.toDouble();
		valorVariacao = plutoRow.cells['valorVariacao']?.value?.toDouble();
		finNaturezaFinanceiraModel = FinNaturezaFinanceiraModel();
		finNaturezaFinanceiraModel?.descricao = plutoRow.cells['finNaturezaFinanceiraModel']?.value;
	}	

	OrcamentoFluxoCaixaDetalheModel clone() {
		return OrcamentoFluxoCaixaDetalheModel(
			id: id,
			idOrcamentoFluxoCaixa: idOrcamentoFluxoCaixa,
			idFinNaturezaFinanceira: idFinNaturezaFinanceira,
			periodo: periodo,
			valorOrcado: valorOrcado,
			valorRealizado: valorRealizado,
			taxaVariacao: taxaVariacao,
			valorVariacao: valorVariacao,
		);			
	}

	
}