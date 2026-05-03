import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:inventario/app/data/domain/domain_imports.dart';

class InventarioContagemCabModel {
	int? id;
	DateTime? dataContagem;
	String? estoqueAtualizado;
	String? tipo;
	List<InventarioContagemDetModel>? inventarioContagemDetModelList;

	InventarioContagemCabModel({
		this.id,
		this.dataContagem,
		this.estoqueAtualizado,
		this.tipo,
		this.inventarioContagemDetModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_contagem',
		'estoque_atualizado',
		'tipo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Contagem',
		'Estoque Atualizado',
		'Tipo',
	];

	InventarioContagemCabModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		dataContagem = jsonData['dataContagem'] != null ? DateTime.tryParse(jsonData['dataContagem']) : null;
		estoqueAtualizado = InventarioContagemCabDomain.getEstoqueAtualizado(jsonData['estoqueAtualizado']);
		tipo = InventarioContagemCabDomain.getTipo(jsonData['tipo']);
		inventarioContagemDetModelList = (jsonData['inventarioContagemDetModelList'] as Iterable?)?.map((m) => InventarioContagemDetModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['dataContagem'] = dataContagem != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataContagem!) : null;
		jsonData['estoqueAtualizado'] = InventarioContagemCabDomain.setEstoqueAtualizado(estoqueAtualizado);
		jsonData['tipo'] = InventarioContagemCabDomain.setTipo(tipo);
		
		var inventarioContagemDetModelLocalList = []; 
		for (InventarioContagemDetModel object in inventarioContagemDetModelList ?? []) { 
			inventarioContagemDetModelLocalList.add(object.toJson); 
		}
		jsonData['inventarioContagemDetModelList'] = inventarioContagemDetModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		dataContagem = Util.stringToDate(plutoRow.cells['dataContagem']?.value);
		estoqueAtualizado = plutoRow.cells['estoqueAtualizado']?.value != '' ? plutoRow.cells['estoqueAtualizado']?.value : 'S';
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Geral';
		inventarioContagemDetModelList = [];
	}	

	InventarioContagemCabModel clone() {
		return InventarioContagemCabModel(
			id: id,
			dataContagem: dataContagem,
			estoqueAtualizado: estoqueAtualizado,
			tipo: tipo,
			inventarioContagemDetModelList: inventarioContagemDetModelListClone(inventarioContagemDetModelList!),
		);			
	}

	inventarioContagemDetModelListClone(List<InventarioContagemDetModel> inventarioContagemDetModelList) { 
		List<InventarioContagemDetModel> resultList = [];
		for (var inventarioContagemDetModel in inventarioContagemDetModelList) {
			resultList.add(
				InventarioContagemDetModel(
					id: inventarioContagemDetModel.id,
					idInventarioContagemCab: inventarioContagemDetModel.idInventarioContagemCab,
					idProduto: inventarioContagemDetModel.idProduto,
					contagem01: inventarioContagemDetModel.contagem01,
					contagem02: inventarioContagemDetModel.contagem02,
					contagem03: inventarioContagemDetModel.contagem03,
					fechadoContagem: inventarioContagemDetModel.fechadoContagem,
					quantidadeSistema: inventarioContagemDetModel.quantidadeSistema,
					acuracidade: inventarioContagemDetModel.acuracidade,
					divergencia: inventarioContagemDetModel.divergencia,
				)
			);
		}
		return resultList;
	}

	
}