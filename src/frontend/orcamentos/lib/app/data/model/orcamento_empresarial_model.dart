import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class OrcamentoEmpresarialModel {
	int? id;
	int? idOrcamentoPeriodo;
	String? nome;
	DateTime? dataInicial;
	int? numeroPeriodos;
	DateTime? dataBase;
	String? descricao;
	List<OrcamentoDetalheModel>? orcamentoDetalheModelList;
	OrcamentoPeriodoModel? orcamentoPeriodoModel;

	OrcamentoEmpresarialModel({
		this.id,
		this.idOrcamentoPeriodo,
		this.nome,
		this.dataInicial,
		this.numeroPeriodos,
		this.dataBase,
		this.descricao,
		this.orcamentoDetalheModelList,
		this.orcamentoPeriodoModel,
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

	OrcamentoEmpresarialModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idOrcamentoPeriodo = jsonData['idOrcamentoPeriodo'];
		nome = jsonData['nome'];
		dataInicial = jsonData['dataInicial'] != null ? DateTime.tryParse(jsonData['dataInicial']) : null;
		numeroPeriodos = jsonData['numeroPeriodos'];
		dataBase = jsonData['dataBase'] != null ? DateTime.tryParse(jsonData['dataBase']) : null;
		descricao = jsonData['descricao'];
		orcamentoDetalheModelList = (jsonData['orcamentoDetalheModelList'] as Iterable?)?.map((m) => OrcamentoDetalheModel.fromJson(m)).toList() ?? [];
		orcamentoPeriodoModel = jsonData['orcamentoPeriodoModel'] == null ? OrcamentoPeriodoModel() : OrcamentoPeriodoModel.fromJson(jsonData['orcamentoPeriodoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idOrcamentoPeriodo'] = idOrcamentoPeriodo != 0 ? idOrcamentoPeriodo : null;
		jsonData['nome'] = nome;
		jsonData['dataInicial'] = dataInicial != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicial!) : null;
		jsonData['numeroPeriodos'] = numeroPeriodos;
		jsonData['dataBase'] = dataBase != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataBase!) : null;
		jsonData['descricao'] = descricao;
		
		var orcamentoDetalheModelLocalList = []; 
		for (OrcamentoDetalheModel object in orcamentoDetalheModelList ?? []) { 
			orcamentoDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['orcamentoDetalheModelList'] = orcamentoDetalheModelLocalList;
		jsonData['orcamentoPeriodoModel'] = orcamentoPeriodoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idOrcamentoPeriodo = plutoRow.cells['idOrcamentoPeriodo']?.value;
		nome = plutoRow.cells['nome']?.value;
		dataInicial = Util.stringToDate(plutoRow.cells['dataInicial']?.value);
		numeroPeriodos = plutoRow.cells['numeroPeriodos']?.value;
		dataBase = Util.stringToDate(plutoRow.cells['dataBase']?.value);
		descricao = plutoRow.cells['descricao']?.value;
		orcamentoDetalheModelList = [];
		orcamentoPeriodoModel = OrcamentoPeriodoModel();
		orcamentoPeriodoModel?.nome = plutoRow.cells['orcamentoPeriodoModel']?.value;
	}	

	OrcamentoEmpresarialModel clone() {
		return OrcamentoEmpresarialModel(
			id: id,
			idOrcamentoPeriodo: idOrcamentoPeriodo,
			nome: nome,
			dataInicial: dataInicial,
			numeroPeriodos: numeroPeriodos,
			dataBase: dataBase,
			descricao: descricao,
			orcamentoDetalheModelList: orcamentoDetalheModelListClone(orcamentoDetalheModelList!),
		);			
	}

	orcamentoDetalheModelListClone(List<OrcamentoDetalheModel> orcamentoDetalheModelList) { 
		List<OrcamentoDetalheModel> resultList = [];
		for (var orcamentoDetalheModel in orcamentoDetalheModelList) {
			resultList.add(
				OrcamentoDetalheModel(
					id: orcamentoDetalheModel.id,
					idOrcamentoEmpresarial: orcamentoDetalheModel.idOrcamentoEmpresarial,
					idFinNaturezaFinanceira: orcamentoDetalheModel.idFinNaturezaFinanceira,
					periodo: orcamentoDetalheModel.periodo,
					valorOrcado: orcamentoDetalheModel.valorOrcado,
					valorRealizado: orcamentoDetalheModel.valorRealizado,
					taxaVariacao: orcamentoDetalheModel.taxaVariacao,
					valorVariacao: orcamentoDetalheModel.valorVariacao,
				)
			);
		}
		return resultList;
	}

	
}