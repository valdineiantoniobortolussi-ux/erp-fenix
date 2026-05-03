import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:inventario/app/data/domain/domain_imports.dart';

class InventarioAjusteCabModel {
	int? id;
	int? idViewPessoaColaborador;
	DateTime? dataAjuste;
	String? tipo;
	double? taxa;
	String? justificativa;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	List<InventarioAjusteDetModel>? inventarioAjusteDetModelList;

	InventarioAjusteCabModel({
		this.id,
		this.idViewPessoaColaborador,
		this.dataAjuste,
		this.tipo,
		this.taxa,
		this.justificativa,
		this.viewPessoaColaboradorModel,
		this.inventarioAjusteDetModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_ajuste',
		'tipo',
		'taxa',
		'justificativa',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Ajuste',
		'Tipo',
		'Taxa',
		'Justificativa',
	];

	InventarioAjusteCabModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idViewPessoaColaborador = jsonData['idViewPessoaColaborador'];
		dataAjuste = jsonData['dataAjuste'] != null ? DateTime.tryParse(jsonData['dataAjuste']) : null;
		tipo = InventarioAjusteCabDomain.getTipo(jsonData['tipo']);
		taxa = jsonData['taxa']?.toDouble();
		justificativa = jsonData['justificativa'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		inventarioAjusteDetModelList = (jsonData['inventarioAjusteDetModelList'] as Iterable?)?.map((m) => InventarioAjusteDetModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idViewPessoaColaborador'] = idViewPessoaColaborador != 0 ? idViewPessoaColaborador : null;
		jsonData['dataAjuste'] = dataAjuste != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAjuste!) : null;
		jsonData['tipo'] = InventarioAjusteCabDomain.setTipo(tipo);
		jsonData['taxa'] = taxa;
		jsonData['justificativa'] = justificativa;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		
		var inventarioAjusteDetModelLocalList = []; 
		for (InventarioAjusteDetModel object in inventarioAjusteDetModelList ?? []) { 
			inventarioAjusteDetModelLocalList.add(object.toJson); 
		}
		jsonData['inventarioAjusteDetModelList'] = inventarioAjusteDetModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idViewPessoaColaborador = plutoRow.cells['idViewPessoaColaborador']?.value;
		dataAjuste = Util.stringToDate(plutoRow.cells['dataAjuste']?.value);
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Aumentar';
		taxa = plutoRow.cells['taxa']?.value?.toDouble();
		justificativa = plutoRow.cells['justificativa']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		inventarioAjusteDetModelList = [];
	}	

	InventarioAjusteCabModel clone() {
		return InventarioAjusteCabModel(
			id: id,
			idViewPessoaColaborador: idViewPessoaColaborador,
			dataAjuste: dataAjuste,
			tipo: tipo,
			taxa: taxa,
			justificativa: justificativa,
			inventarioAjusteDetModelList: inventarioAjusteDetModelListClone(inventarioAjusteDetModelList!),
		);			
	}

	inventarioAjusteDetModelListClone(List<InventarioAjusteDetModel> inventarioAjusteDetModelList) { 
		List<InventarioAjusteDetModel> resultList = [];
		for (var inventarioAjusteDetModel in inventarioAjusteDetModelList) {
			resultList.add(
				InventarioAjusteDetModel(
					id: inventarioAjusteDetModel.id,
					idInventarioAjusteCab: inventarioAjusteDetModel.idInventarioAjusteCab,
					idProduto: inventarioAjusteDetModel.idProduto,
					valorOriginal: inventarioAjusteDetModel.valorOriginal,
					valorReajuste: inventarioAjusteDetModel.valorReajuste,
				)
			);
		}
		return resultList;
	}

	
}