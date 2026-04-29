import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilLivroModel {
	int? id;
	String? competencia;
	String? formaEscrituracao;
	String? descricao;
	List<ContabilTermoModel>? contabilTermoModelList;

	ContabilLivroModel({
		this.id,
		this.competencia,
		this.formaEscrituracao,
		this.descricao,
		this.contabilTermoModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'competencia',
		'forma_escrituracao',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Competencia',
		'Forma Escrituracao',
		'Descricao',
	];

	ContabilLivroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		competencia = jsonData['competencia'];
		formaEscrituracao = ContabilLivroDomain.getFormaEscrituracao(jsonData['formaEscrituracao']);
		descricao = jsonData['descricao'];
		contabilTermoModelList = (jsonData['contabilTermoModelList'] as Iterable?)?.map((m) => ContabilTermoModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['competencia'] = Util.removeMask(competencia);
		jsonData['formaEscrituracao'] = ContabilLivroDomain.setFormaEscrituracao(formaEscrituracao);
		jsonData['descricao'] = descricao;
		
		var contabilTermoModelLocalList = []; 
		for (ContabilTermoModel object in contabilTermoModelList ?? []) { 
			contabilTermoModelLocalList.add(object.toJson); 
		}
		jsonData['contabilTermoModelList'] = contabilTermoModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		competencia = plutoRow.cells['competencia']?.value;
		formaEscrituracao = plutoRow.cells['formaEscrituracao']?.value != '' ? plutoRow.cells['formaEscrituracao']?.value : 'Diário Geral';
		descricao = plutoRow.cells['descricao']?.value;
		contabilTermoModelList = [];
	}	

	ContabilLivroModel clone() {
		return ContabilLivroModel(
			id: id,
			competencia: competencia,
			formaEscrituracao: formaEscrituracao,
			descricao: descricao,
			contabilTermoModelList: contabilTermoModelListClone(contabilTermoModelList!),
		);			
	}

	contabilTermoModelListClone(List<ContabilTermoModel> contabilTermoModelList) { 
		List<ContabilTermoModel> resultList = [];
		for (var contabilTermoModel in contabilTermoModelList) {
			resultList.add(
				ContabilTermoModel(
					id: contabilTermoModel.id,
					idContabilLivro: contabilTermoModel.idContabilLivro,
					aberturaEncerramento: contabilTermoModel.aberturaEncerramento,
					numero: contabilTermoModel.numero,
					paginaInicial: contabilTermoModel.paginaInicial,
					paginaFinal: contabilTermoModel.paginaFinal,
					registrado: contabilTermoModel.registrado,
					numeroRegistro: contabilTermoModel.numeroRegistro,
					dataDespacho: contabilTermoModel.dataDespacho,
					dataAbertura: contabilTermoModel.dataAbertura,
					dataEncerramento: contabilTermoModel.dataEncerramento,
					escrituracaoInicio: contabilTermoModel.escrituracaoInicio,
					escrituracaoFim: contabilTermoModel.escrituracaoFim,
					texto: contabilTermoModel.texto,
				)
			);
		}
		return resultList;
	}

	
}