import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:estoque/app/data/domain/domain_imports.dart';

class RequisicaoInternaCabecalhoModel {
	int? id;
	int? idColaborador;
	DateTime? dataRequisicao;
	String? situacao;
	List<RequisicaoInternaDetalheModel>? requisicaoInternaDetalheModelList;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	RequisicaoInternaCabecalhoModel({
		this.id,
		this.idColaborador,
		this.dataRequisicao,
		this.situacao,
		this.requisicaoInternaDetalheModelList,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_requisicao',
		'situacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Requisicao',
		'Situacao',
	];

	RequisicaoInternaCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		dataRequisicao = jsonData['dataRequisicao'] != null ? DateTime.tryParse(jsonData['dataRequisicao']) : null;
		situacao = RequisicaoInternaCabecalhoDomain.getSituacao(jsonData['situacao']);
		requisicaoInternaDetalheModelList = (jsonData['requisicaoInternaDetalheModelList'] as Iterable?)?.map((m) => RequisicaoInternaDetalheModel.fromJson(m)).toList() ?? [];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['dataRequisicao'] = dataRequisicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataRequisicao!) : null;
		jsonData['situacao'] = RequisicaoInternaCabecalhoDomain.setSituacao(situacao);
		
		var requisicaoInternaDetalheModelLocalList = []; 
		for (RequisicaoInternaDetalheModel object in requisicaoInternaDetalheModelList ?? []) { 
			requisicaoInternaDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['requisicaoInternaDetalheModelList'] = requisicaoInternaDetalheModelLocalList;
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
		dataRequisicao = Util.stringToDate(plutoRow.cells['dataRequisicao']?.value);
		situacao = plutoRow.cells['situacao']?.value != '' ? plutoRow.cells['situacao']?.value : 'Aberta';
		requisicaoInternaDetalheModelList = [];
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	RequisicaoInternaCabecalhoModel clone() {
		return RequisicaoInternaCabecalhoModel(
			id: id,
			idColaborador: idColaborador,
			dataRequisicao: dataRequisicao,
			situacao: situacao,
			requisicaoInternaDetalheModelList: requisicaoInternaDetalheModelListClone(requisicaoInternaDetalheModelList!),
		);			
	}

	requisicaoInternaDetalheModelListClone(List<RequisicaoInternaDetalheModel> requisicaoInternaDetalheModelList) { 
		List<RequisicaoInternaDetalheModel> resultList = [];
		for (var requisicaoInternaDetalheModel in requisicaoInternaDetalheModelList) {
			resultList.add(
				RequisicaoInternaDetalheModel(
					id: requisicaoInternaDetalheModel.id,
					idRequisicaoInternaCabecalho: requisicaoInternaDetalheModel.idRequisicaoInternaCabecalho,
					idProduto: requisicaoInternaDetalheModel.idProduto,
					quantidade: requisicaoInternaDetalheModel.quantidade,
				)
			);
		}
		return resultList;
	}

	
}