import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaLancamentoCabecalhoModel {
	int? id;
	int? idColaborador;
	String? competencia;
	String? tipo;
	List<FolhaLancamentoDetalheModel>? folhaLancamentoDetalheModelList;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	FolhaLancamentoCabecalhoModel({
		this.id,
		this.idColaborador,
		this.competencia,
		this.tipo,
		this.folhaLancamentoDetalheModelList,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'competencia',
		'tipo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Competencia',
		'Tipo',
	];

	FolhaLancamentoCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		competencia = jsonData['competencia'];
		tipo = FolhaLancamentoCabecalhoDomain.getTipo(jsonData['tipo']);
		folhaLancamentoDetalheModelList = (jsonData['folhaLancamentoDetalheModelList'] as Iterable?)?.map((m) => FolhaLancamentoDetalheModel.fromJson(m)).toList() ?? [];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['competencia'] = competencia;
		jsonData['tipo'] = FolhaLancamentoCabecalhoDomain.setTipo(tipo);
		
		var folhaLancamentoDetalheModelLocalList = []; 
		for (FolhaLancamentoDetalheModel object in folhaLancamentoDetalheModelList ?? []) { 
			folhaLancamentoDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['folhaLancamentoDetalheModelList'] = folhaLancamentoDetalheModelLocalList;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		competencia = plutoRow.cells['competencia']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Folha Mensal';
		folhaLancamentoDetalheModelList = [];
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	FolhaLancamentoCabecalhoModel clone() {
		return FolhaLancamentoCabecalhoModel(
			id: id,
			idColaborador: idColaborador,
			competencia: competencia,
			tipo: tipo,
			folhaLancamentoDetalheModelList: folhaLancamentoDetalheModelListClone(folhaLancamentoDetalheModelList!),
		);			
	}

	folhaLancamentoDetalheModelListClone(List<FolhaLancamentoDetalheModel> folhaLancamentoDetalheModelList) { 
		List<FolhaLancamentoDetalheModel> resultList = [];
		for (var folhaLancamentoDetalheModel in folhaLancamentoDetalheModelList) {
			resultList.add(
				FolhaLancamentoDetalheModel(
					id: folhaLancamentoDetalheModel.id,
					idFolhaLancamentoCabecalho: folhaLancamentoDetalheModel.idFolhaLancamentoCabecalho,
					idFolhaEvento: folhaLancamentoDetalheModel.idFolhaEvento,
					origem: folhaLancamentoDetalheModel.origem,
					provento: folhaLancamentoDetalheModel.provento,
					desconto: folhaLancamentoDetalheModel.desconto,
				)
			);
		}
		return resultList;
	}

	
}