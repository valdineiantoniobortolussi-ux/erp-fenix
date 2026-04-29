import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoBancoHorasModel {
	int? id;
	int? idColaborador;
	DateTime? dataTrabalho;
	String? quantidade;
	String? situacao;
	List<PontoBancoHorasUtilizacaoModel>? pontoBancoHorasUtilizacaoModelList;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	PontoBancoHorasModel({
		this.id,
		this.idColaborador,
		this.dataTrabalho,
		this.quantidade,
		this.situacao,
		this.pontoBancoHorasUtilizacaoModelList,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_trabalho',
		'quantidade',
		'situacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Trabalho',
		'Quantidade',
		'Situacao',
	];

	PontoBancoHorasModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		dataTrabalho = jsonData['dataTrabalho'] != null ? DateTime.tryParse(jsonData['dataTrabalho']) : null;
		quantidade = jsonData['quantidade'];
		situacao = PontoBancoHorasDomain.getSituacao(jsonData['situacao']);
		pontoBancoHorasUtilizacaoModelList = (jsonData['pontoBancoHorasUtilizacaoModelList'] as Iterable?)?.map((m) => PontoBancoHorasUtilizacaoModel.fromJson(m)).toList() ?? [];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['dataTrabalho'] = dataTrabalho != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataTrabalho!) : null;
		jsonData['quantidade'] = quantidade;
		jsonData['situacao'] = PontoBancoHorasDomain.setSituacao(situacao);
		
		var pontoBancoHorasUtilizacaoModelLocalList = []; 
		for (PontoBancoHorasUtilizacaoModel object in pontoBancoHorasUtilizacaoModelList ?? []) { 
			pontoBancoHorasUtilizacaoModelLocalList.add(object.toJson); 
		}
		jsonData['pontoBancoHorasUtilizacaoModelList'] = pontoBancoHorasUtilizacaoModelLocalList;
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
		dataTrabalho = Util.stringToDate(plutoRow.cells['dataTrabalho']?.value);
		quantidade = plutoRow.cells['quantidade']?.value;
		situacao = plutoRow.cells['situacao']?.value != '' ? plutoRow.cells['situacao']?.value : 'Não Utilizado';
		pontoBancoHorasUtilizacaoModelList = [];
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	PontoBancoHorasModel clone() {
		return PontoBancoHorasModel(
			id: id,
			idColaborador: idColaborador,
			dataTrabalho: dataTrabalho,
			quantidade: quantidade,
			situacao: situacao,
			pontoBancoHorasUtilizacaoModelList: pontoBancoHorasUtilizacaoModelListClone(pontoBancoHorasUtilizacaoModelList!),
		);			
	}

	pontoBancoHorasUtilizacaoModelListClone(List<PontoBancoHorasUtilizacaoModel> pontoBancoHorasUtilizacaoModelList) { 
		List<PontoBancoHorasUtilizacaoModel> resultList = [];
		for (var pontoBancoHorasUtilizacaoModel in pontoBancoHorasUtilizacaoModelList) {
			resultList.add(
				PontoBancoHorasUtilizacaoModel(
					id: pontoBancoHorasUtilizacaoModel.id,
					idPontoBancoHoras: pontoBancoHorasUtilizacaoModel.idPontoBancoHoras,
					dataUtilizacao: pontoBancoHorasUtilizacaoModel.dataUtilizacao,
					quantidadeUtilizada: pontoBancoHorasUtilizacaoModel.quantidadeUtilizada,
					observacao: pontoBancoHorasUtilizacaoModel.observacao,
				)
			);
		}
		return resultList;
	}

	
}