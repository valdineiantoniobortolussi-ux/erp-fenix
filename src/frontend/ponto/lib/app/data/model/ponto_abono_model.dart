import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class PontoAbonoModel {
	int? id;
	int? idColaborador;
	int? quantidade;
	int? utilizado;
	int? saldo;
	DateTime? dataCadastro;
	DateTime? inicioUtilizacao;
	DateTime? dataValidade;
	String? observacao;
	List<PontoAbonoUtilizacaoModel>? pontoAbonoUtilizacaoModelList;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	PontoAbonoModel({
		this.id,
		this.idColaborador,
		this.quantidade,
		this.utilizado,
		this.saldo,
		this.dataCadastro,
		this.inicioUtilizacao,
		this.dataValidade,
		this.observacao,
		this.pontoAbonoUtilizacaoModelList,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'quantidade',
		'utilizado',
		'saldo',
		'data_cadastro',
		'inicio_utilizacao',
		'data_validade',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade',
		'Utilizado',
		'Saldo',
		'Data Cadastro',
		'Inicio Utilizacao',
		'Data Validade',
		'Observacao',
	];

	PontoAbonoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		quantidade = jsonData['quantidade'];
		utilizado = jsonData['utilizado'];
		saldo = jsonData['saldo'];
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		inicioUtilizacao = jsonData['inicioUtilizacao'] != null ? DateTime.tryParse(jsonData['inicioUtilizacao']) : null;
		dataValidade = jsonData['dataValidade'] != null ? DateTime.tryParse(jsonData['dataValidade']) : null;
		observacao = jsonData['observacao'];
		pontoAbonoUtilizacaoModelList = (jsonData['pontoAbonoUtilizacaoModelList'] as Iterable?)?.map((m) => PontoAbonoUtilizacaoModel.fromJson(m)).toList() ?? [];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['quantidade'] = quantidade;
		jsonData['utilizado'] = utilizado;
		jsonData['saldo'] = saldo;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['inicioUtilizacao'] = inicioUtilizacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(inicioUtilizacao!) : null;
		jsonData['dataValidade'] = dataValidade != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataValidade!) : null;
		jsonData['observacao'] = observacao;
		
		var pontoAbonoUtilizacaoModelLocalList = []; 
		for (PontoAbonoUtilizacaoModel object in pontoAbonoUtilizacaoModelList ?? []) { 
			pontoAbonoUtilizacaoModelLocalList.add(object.toJson); 
		}
		jsonData['pontoAbonoUtilizacaoModelList'] = pontoAbonoUtilizacaoModelLocalList;
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
		quantidade = plutoRow.cells['quantidade']?.value;
		utilizado = plutoRow.cells['utilizado']?.value;
		saldo = plutoRow.cells['saldo']?.value;
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		inicioUtilizacao = Util.stringToDate(plutoRow.cells['inicioUtilizacao']?.value);
		dataValidade = Util.stringToDate(plutoRow.cells['dataValidade']?.value);
		observacao = plutoRow.cells['observacao']?.value;
		pontoAbonoUtilizacaoModelList = [];
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	PontoAbonoModel clone() {
		return PontoAbonoModel(
			id: id,
			idColaborador: idColaborador,
			quantidade: quantidade,
			utilizado: utilizado,
			saldo: saldo,
			dataCadastro: dataCadastro,
			inicioUtilizacao: inicioUtilizacao,
			dataValidade: dataValidade,
			observacao: observacao,
			pontoAbonoUtilizacaoModelList: pontoAbonoUtilizacaoModelListClone(pontoAbonoUtilizacaoModelList!),
		);			
	}

	pontoAbonoUtilizacaoModelListClone(List<PontoAbonoUtilizacaoModel> pontoAbonoUtilizacaoModelList) { 
		List<PontoAbonoUtilizacaoModel> resultList = [];
		for (var pontoAbonoUtilizacaoModel in pontoAbonoUtilizacaoModelList) {
			resultList.add(
				PontoAbonoUtilizacaoModel(
					id: pontoAbonoUtilizacaoModel.id,
					idPontoAbono: pontoAbonoUtilizacaoModel.idPontoAbono,
					dataUtilizacao: pontoAbonoUtilizacaoModel.dataUtilizacao,
					observacao: pontoAbonoUtilizacaoModel.observacao,
				)
			);
		}
		return resultList;
	}

	
}