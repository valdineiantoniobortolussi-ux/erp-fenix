import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class OrcamentoFluxoCaixaModel {
	int? id;
	int? idOrcFluxoCaixaPeriodo;
	String? nome;
	DateTime? dataInicial;
	int? numeroPeriodos;
	DateTime? dataBase;
	String? descricao;
	List<OrcamentoFluxoCaixaDetalheModel>? orcamentoFluxoCaixaDetalheModelList;
	OrcamentoFluxoCaixaPeriodoModel? orcamentoFluxoCaixaPeriodoModel;

	OrcamentoFluxoCaixaModel({
		this.id,
		this.idOrcFluxoCaixaPeriodo,
		this.nome,
		this.dataInicial,
		this.numeroPeriodos,
		this.dataBase,
		this.descricao,
		this.orcamentoFluxoCaixaDetalheModelList,
		this.orcamentoFluxoCaixaPeriodoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'data_inicial',
		'numero_periodos',
		'data_base',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Data Inicial',
		'Numero Periodos',
		'Data Base',
		'Descricao',
	];

	OrcamentoFluxoCaixaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idOrcFluxoCaixaPeriodo = jsonData['idOrcFluxoCaixaPeriodo'];
		nome = jsonData['nome'];
		dataInicial = jsonData['dataInicial'] != null ? DateTime.tryParse(jsonData['dataInicial']) : null;
		numeroPeriodos = jsonData['numeroPeriodos'];
		dataBase = jsonData['dataBase'] != null ? DateTime.tryParse(jsonData['dataBase']) : null;
		descricao = jsonData['descricao'];
		orcamentoFluxoCaixaDetalheModelList = (jsonData['orcamentoFluxoCaixaDetalheModelList'] as Iterable?)?.map((m) => OrcamentoFluxoCaixaDetalheModel.fromJson(m)).toList() ?? [];
		orcamentoFluxoCaixaPeriodoModel = jsonData['orcamentoFluxoCaixaPeriodoModel'] == null ? OrcamentoFluxoCaixaPeriodoModel() : OrcamentoFluxoCaixaPeriodoModel.fromJson(jsonData['orcamentoFluxoCaixaPeriodoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idOrcFluxoCaixaPeriodo'] = idOrcFluxoCaixaPeriodo != 0 ? idOrcFluxoCaixaPeriodo : null;
		jsonData['nome'] = nome;
		jsonData['dataInicial'] = dataInicial != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicial!) : null;
		jsonData['numeroPeriodos'] = numeroPeriodos;
		jsonData['dataBase'] = dataBase != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataBase!) : null;
		jsonData['descricao'] = descricao;
		
		var orcamentoFluxoCaixaDetalheModelLocalList = []; 
		for (OrcamentoFluxoCaixaDetalheModel object in orcamentoFluxoCaixaDetalheModelList ?? []) { 
			orcamentoFluxoCaixaDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['orcamentoFluxoCaixaDetalheModelList'] = orcamentoFluxoCaixaDetalheModelLocalList;
		jsonData['orcamentoFluxoCaixaPeriodoModel'] = orcamentoFluxoCaixaPeriodoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idOrcFluxoCaixaPeriodo = plutoRow.cells['idOrcFluxoCaixaPeriodo']?.value;
		nome = plutoRow.cells['nome']?.value;
		dataInicial = Util.stringToDate(plutoRow.cells['dataInicial']?.value);
		numeroPeriodos = plutoRow.cells['numeroPeriodos']?.value;
		dataBase = Util.stringToDate(plutoRow.cells['dataBase']?.value);
		descricao = plutoRow.cells['descricao']?.value;
		orcamentoFluxoCaixaDetalheModelList = [];
		orcamentoFluxoCaixaPeriodoModel = OrcamentoFluxoCaixaPeriodoModel();
		orcamentoFluxoCaixaPeriodoModel?.nome = plutoRow.cells['orcamentoFluxoCaixaPeriodoModel']?.value;
	}	

	OrcamentoFluxoCaixaModel clone() {
		return OrcamentoFluxoCaixaModel(
			id: id,
			idOrcFluxoCaixaPeriodo: idOrcFluxoCaixaPeriodo,
			nome: nome,
			dataInicial: dataInicial,
			numeroPeriodos: numeroPeriodos,
			dataBase: dataBase,
			descricao: descricao,
			orcamentoFluxoCaixaDetalheModelList: orcamentoFluxoCaixaDetalheModelListClone(orcamentoFluxoCaixaDetalheModelList!),
		);			
	}

	orcamentoFluxoCaixaDetalheModelListClone(List<OrcamentoFluxoCaixaDetalheModel> orcamentoFluxoCaixaDetalheModelList) { 
		List<OrcamentoFluxoCaixaDetalheModel> resultList = [];
		for (var orcamentoFluxoCaixaDetalheModel in orcamentoFluxoCaixaDetalheModelList) {
			resultList.add(
				OrcamentoFluxoCaixaDetalheModel(
					id: orcamentoFluxoCaixaDetalheModel.id,
					idOrcamentoFluxoCaixa: orcamentoFluxoCaixaDetalheModel.idOrcamentoFluxoCaixa,
					idFinNaturezaFinanceira: orcamentoFluxoCaixaDetalheModel.idFinNaturezaFinanceira,
					periodo: orcamentoFluxoCaixaDetalheModel.periodo,
					valorOrcado: orcamentoFluxoCaixaDetalheModel.valorOrcado,
					valorRealizado: orcamentoFluxoCaixaDetalheModel.valorRealizado,
					taxaVariacao: orcamentoFluxoCaixaDetalheModel.taxaVariacao,
					valorVariacao: orcamentoFluxoCaixaDetalheModel.valorVariacao,
				)
			);
		}
		return resultList;
	}

	
}