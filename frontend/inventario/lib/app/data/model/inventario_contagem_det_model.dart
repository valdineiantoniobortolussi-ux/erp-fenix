import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:inventario/app/data/model/model_imports.dart';
import 'package:inventario/app/data/domain/domain_imports.dart';

class InventarioContagemDetModel {
	int? id;
	int? idInventarioContagemCab;
	int? idProduto;
	double? contagem01;
	double? contagem02;
	double? contagem03;
	String? fechadoContagem;
	double? quantidadeSistema;
	double? acuracidade;
	double? divergencia;
	ProdutoModel? produtoModel;

	InventarioContagemDetModel({
		this.id,
		this.idInventarioContagemCab,
		this.idProduto,
		this.contagem01,
		this.contagem02,
		this.contagem03,
		this.fechadoContagem,
		this.quantidadeSistema,
		this.acuracidade,
		this.divergencia,
		this.produtoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'contagem01',
		'contagem02',
		'contagem03',
		'fechado_contagem',
		'quantidade_sistema',
		'acuracidade',
		'divergencia',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Contagem01',
		'Contagem02',
		'Contagem03',
		'Fechado Contagem',
		'Quantidade Sistema',
		'Acuracidade',
		'Divergencia',
	];

	InventarioContagemDetModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idInventarioContagemCab = jsonData['idInventarioContagemCab'];
		idProduto = jsonData['idProduto'];
		contagem01 = jsonData['contagem01']?.toDouble();
		contagem02 = jsonData['contagem02']?.toDouble();
		contagem03 = jsonData['contagem03']?.toDouble();
		fechadoContagem = InventarioContagemDetDomain.getFechadoContagem(jsonData['fechadoContagem']);
		quantidadeSistema = jsonData['quantidadeSistema']?.toDouble();
		acuracidade = jsonData['acuracidade']?.toDouble();
		divergencia = jsonData['divergencia']?.toDouble();
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idInventarioContagemCab'] = idInventarioContagemCab != 0 ? idInventarioContagemCab : null;
		jsonData['idProduto'] = idProduto != 0 ? idProduto : null;
		jsonData['contagem01'] = contagem01;
		jsonData['contagem02'] = contagem02;
		jsonData['contagem03'] = contagem03;
		jsonData['fechadoContagem'] = InventarioContagemDetDomain.setFechadoContagem(fechadoContagem);
		jsonData['quantidadeSistema'] = quantidadeSistema;
		jsonData['acuracidade'] = acuracidade;
		jsonData['divergencia'] = divergencia;
		jsonData['produtoModel'] = produtoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idInventarioContagemCab = plutoRow.cells['idInventarioContagemCab']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		contagem01 = plutoRow.cells['contagem01']?.value?.toDouble();
		contagem02 = plutoRow.cells['contagem02']?.value?.toDouble();
		contagem03 = plutoRow.cells['contagem03']?.value?.toDouble();
		fechadoContagem = plutoRow.cells['fechadoContagem']?.value != '' ? plutoRow.cells['fechadoContagem']?.value : '01';
		quantidadeSistema = plutoRow.cells['quantidadeSistema']?.value?.toDouble();
		acuracidade = plutoRow.cells['acuracidade']?.value?.toDouble();
		divergencia = plutoRow.cells['divergencia']?.value?.toDouble();
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	InventarioContagemDetModel clone() {
		return InventarioContagemDetModel(
			id: id,
			idInventarioContagemCab: idInventarioContagemCab,
			idProduto: idProduto,
			contagem01: contagem01,
			contagem02: contagem02,
			contagem03: contagem03,
			fechadoContagem: fechadoContagem,
			quantidadeSistema: quantidadeSistema,
			acuracidade: acuracidade,
			divergencia: divergencia,
		);			
	}

	
}