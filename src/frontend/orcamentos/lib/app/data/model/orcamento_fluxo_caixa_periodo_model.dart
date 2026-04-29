import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:orcamentos/app/data/model/model_imports.dart';
import 'package:orcamentos/app/data/domain/domain_imports.dart';

class OrcamentoFluxoCaixaPeriodoModel {
	int? id;
	int? idBancoContaCaixa;
	String? periodo;
	String? nome;
	BancoContaCaixaModel? bancoContaCaixaModel;

	OrcamentoFluxoCaixaPeriodoModel({
		this.id,
		this.idBancoContaCaixa,
		this.periodo,
		this.nome,
		this.bancoContaCaixaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'periodo',
		'nome',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Periodo',
		'Nome',
	];

	OrcamentoFluxoCaixaPeriodoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idBancoContaCaixa = jsonData['idBancoContaCaixa'];
		periodo = OrcamentoFluxoCaixaPeriodoDomain.getPeriodo(jsonData['periodo']);
		nome = jsonData['nome'];
		bancoContaCaixaModel = jsonData['bancoContaCaixaModel'] == null ? BancoContaCaixaModel() : BancoContaCaixaModel.fromJson(jsonData['bancoContaCaixaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idBancoContaCaixa'] = idBancoContaCaixa != 0 ? idBancoContaCaixa : null;
		jsonData['periodo'] = OrcamentoFluxoCaixaPeriodoDomain.setPeriodo(periodo);
		jsonData['nome'] = nome;
		jsonData['bancoContaCaixaModel'] = bancoContaCaixaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idBancoContaCaixa = plutoRow.cells['idBancoContaCaixa']?.value;
		periodo = plutoRow.cells['periodo']?.value != '' ? plutoRow.cells['periodo']?.value : '01=Diário';
		nome = plutoRow.cells['nome']?.value;
		bancoContaCaixaModel = BancoContaCaixaModel();
		bancoContaCaixaModel?.nome = plutoRow.cells['bancoContaCaixaModel']?.value;
	}	

	OrcamentoFluxoCaixaPeriodoModel clone() {
		return OrcamentoFluxoCaixaPeriodoModel(
			id: id,
			idBancoContaCaixa: idBancoContaCaixa,
			periodo: periodo,
			nome: nome,
		);			
	}

	
}