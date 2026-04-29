import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class CompraRequisicaoModel {
	int? id;
	int? idCompraTipoRequisicao;
	int? idColaborador;
	String? descricao;
	DateTime? dataRequisicao;
	String? observacao;
	List<CompraRequisicaoDetalheModel>? compraRequisicaoDetalheModelList;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	CompraTipoRequisicaoModel? compraTipoRequisicaoModel;

	CompraRequisicaoModel({
		this.id,
		this.idCompraTipoRequisicao,
		this.idColaborador,
		this.descricao,
		this.dataRequisicao,
		this.observacao,
		this.compraRequisicaoDetalheModelList,
		this.viewPessoaColaboradorModel,
		this.compraTipoRequisicaoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
		'data_requisicao',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
		'Data Requisicao',
		'Observacao',
	];

	CompraRequisicaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCompraTipoRequisicao = jsonData['idCompraTipoRequisicao'];
		idColaborador = jsonData['idColaborador'];
		descricao = jsonData['descricao'];
		dataRequisicao = jsonData['dataRequisicao'] != null ? DateTime.tryParse(jsonData['dataRequisicao']) : null;
		observacao = jsonData['observacao'];
		compraRequisicaoDetalheModelList = (jsonData['compraRequisicaoDetalheModelList'] as Iterable?)?.map((m) => CompraRequisicaoDetalheModel.fromJson(m)).toList() ?? [];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		compraTipoRequisicaoModel = jsonData['compraTipoRequisicaoModel'] == null ? CompraTipoRequisicaoModel() : CompraTipoRequisicaoModel.fromJson(jsonData['compraTipoRequisicaoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCompraTipoRequisicao'] = idCompraTipoRequisicao != 0 ? idCompraTipoRequisicao : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['descricao'] = descricao;
		jsonData['dataRequisicao'] = dataRequisicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataRequisicao!) : null;
		jsonData['observacao'] = observacao;
		
		var compraRequisicaoDetalheModelLocalList = []; 
		for (CompraRequisicaoDetalheModel object in compraRequisicaoDetalheModelList ?? []) { 
			compraRequisicaoDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['compraRequisicaoDetalheModelList'] = compraRequisicaoDetalheModelLocalList;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		jsonData['compraTipoRequisicaoModel'] = compraTipoRequisicaoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCompraTipoRequisicao = plutoRow.cells['idCompraTipoRequisicao']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		dataRequisicao = Util.stringToDate(plutoRow.cells['dataRequisicao']?.value);
		observacao = plutoRow.cells['observacao']?.value;
		compraRequisicaoDetalheModelList = [];
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		compraTipoRequisicaoModel = CompraTipoRequisicaoModel();
		compraTipoRequisicaoModel?.nome = plutoRow.cells['compraTipoRequisicaoModel']?.value;
	}	

	CompraRequisicaoModel clone() {
		return CompraRequisicaoModel(
			id: id,
			idCompraTipoRequisicao: idCompraTipoRequisicao,
			idColaborador: idColaborador,
			descricao: descricao,
			dataRequisicao: dataRequisicao,
			observacao: observacao,
			compraRequisicaoDetalheModelList: compraRequisicaoDetalheModelListClone(compraRequisicaoDetalheModelList!),
		);			
	}

	compraRequisicaoDetalheModelListClone(List<CompraRequisicaoDetalheModel> compraRequisicaoDetalheModelList) { 
		List<CompraRequisicaoDetalheModel> resultList = [];
		for (var compraRequisicaoDetalheModel in compraRequisicaoDetalheModelList) {
			resultList.add(
				CompraRequisicaoDetalheModel(
					id: compraRequisicaoDetalheModel.id,
					idCompraRequisicao: compraRequisicaoDetalheModel.idCompraRequisicao,
					idProduto: compraRequisicaoDetalheModel.idProduto,
					quantidade: compraRequisicaoDetalheModel.quantidade,
				)
			);
		}
		return resultList;
	}

	
}